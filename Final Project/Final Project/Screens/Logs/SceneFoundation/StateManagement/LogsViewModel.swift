//
//  LogsViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import Foundation
import SwiftUI

@MainActor
final class LogsViewModel: ObservableObject {

    @Published private(set) var containers: [ContainerInfo] = []
    @Published private(set) var selectedContainer: ContainerInfo? = nil
    @Published private(set) var logs: [LogLine] = []
    @Published private(set) var filteredLogs: [LogLine] = []
    @Published private(set) var isStreaming: Bool = false

    @Published var isPaused: Bool = false
    @Published var selectedLevel: LogLevel = .all { didSet { applyFilter() } }
    @Published var autoScroll: Bool = true

    @Published var loadError: String? = nil
    @Published var streamError: String? = nil

    static let maxLogs = 1500

    private let service: LumenService
    private let logsStreaming: LogsStreaming
    private let containerLogic: LogsContainerLogic
    private let streamLogic: LogsStreamLogic
    private let filterLogic: LogsFilterLogic

    private var didInitialLoad = false

    init(
        service: LumenService = AppEnvironment.makeLumenService(),
        logsStreaming: LogsStreaming = AppEnvironment.makeLogsStreaming()
    ) {
        self.service = service
        self.logsStreaming = logsStreaming
        self.containerLogic = LogsContainerLogic()
        self.streamLogic = LogsStreamLogic()
        self.filterLogic = LogsFilterLogic()
    }

    // MARK: - Lifecycle

    func onAppear(preselect: ContainerInfo?, externalContainers: [ContainerInfo]) {
        if !externalContainers.isEmpty {
            updateContainers(externalContainers, preselect: preselect)
        }

        guard !didInitialLoad else {
            resumeIfNeeded()
            return
        }

        didInitialLoad = true

        Task { [weak self] in
            await self?.loadContainers(preselect: preselect)
        }
    }

    func onDisappear() {
        stopStream()
    }

    // MARK: - Containers

    func updateContainers(_ list: [ContainerInfo], preselect: ContainerInfo?) {
        containerLogic.updateContainers(
            list,
            preselect: preselect,
            currentContainers: containers,
            currentSelected: selectedContainer,
            applyContainers: { [weak self] newValue in
                self?.containers = newValue
            },
            select: { [weak self] c in
                self?.select(c)
            },
            clearSelection: { [weak self] in
                self?.selectedContainer = nil
                self?.stopStream()
                self?.clearLogs()
            }
        )
    }

    func select(_ container: ContainerInfo) {
        guard selectedContainer?.id != container.id else { return }

        streamLogic.markUserStop()
        stopStream()

        logs.removeAll()
        filteredLogs.removeAll()
        streamLogic.clearPending()
        isPaused = false
        selectedLevel = .all
        streamLogic.resetAttempts()
        streamError = nil

        selectedContainer = container

        guard container.isRunning else {
            isStreaming = false
            streamError = "Container is not running — start it to stream logs."  
            return
        }

        streamLogic.markAutoStopAllowed()
        startStreamWithRetry(for: container)
    }

    func loadContainers(preselect: ContainerInfo?) async {
        do {
            let list = try await service.listContainers()
            loadError = nil
            updateContainers(list, preselect: preselect)
        } catch {
            loadError = error.localizedDescription
        }
    }

    // MARK: - Stream control

    func resumeIfNeeded() {
        guard !streamLogic.hasActiveTask else { return }
        guard let c = selectedContainer, c.isRunning else { return }

        streamError = nil
        streamLogic.resetAttempts()
        streamLogic.markAutoStopAllowed()
        startStreamWithRetry(for: c)
    }

    func stopStream() {
        streamLogic.markUserStop()
        streamLogic.cancelTask()
        isStreaming = false
    }

    func pause() {
        isPaused = true
        streamLogic.clearPending()
    }

    func resume() {
        isPaused = false
        let pending = streamLogic.drainPending()
        for line in pending {
            appendLog(line)
        }
    }

    func clearLogs() {
        logs.removeAll()
        filteredLogs.removeAll()
        streamLogic.clearPending()
    }

    // MARK: - Filter

    func countForLevel(_ level: LogLevel) -> Int {
        filterLogic.count(logs: logs, level: level)
    }

    private func applyFilter() {
        filteredLogs = filterLogic.filtered(logs: logs, selected: selectedLevel)
    }

    // MARK: - Private

    private func startStreamWithRetry(for container: ContainerInfo) {
        guard !streamLogic.hasActiveTask else { return }

        isStreaming = true
        streamError = nil

        streamLogic.startTask { [weak self] in
            guard let self else { return }

            while !Task.isCancelled {
                do {
                    try await self.runStreamOnce(containerId: container.id)
                    break
                } catch {
                    if Task.isCancelled { break }
                    if self.streamLogic.userStopped { break }

                    self.streamLogic.bumpAttempt()

                    if self.streamLogic.exceededMaxAttempts {
                        self.streamError = "Stream failed after multiple retries."
                        break
                    }

                    self.streamError = "Reconnecting..."
                    try? await WebSocketBackoff.sleep(attempt: self.streamLogic.streamAttempt)
                }
            }

            if !Task.isCancelled {
                self.isStreaming = false
                self.streamLogic.finishTask()
            }
        }
    }

    private func runStreamOnce(containerId: String) async throws {
        let stream = logsStreaming.stream(containerId: containerId)

        for try await line in stream {
            if Task.isCancelled { break }

            streamError = nil

            if isPaused {
                streamLogic.pushPending(line)
            } else {
                appendLog(line)
            }
        }
    }

    private func appendLog(_ line: LogLine) {
        let normalized = normalizeIfNeeded(line)

        logs.append(normalized)
        if logs.count > Self.maxLogs {
            logs.removeFirst(logs.count - Self.maxLogs)
        }

        guard selectedLevel == .all || normalized.level == selectedLevel else { return }

        filteredLogs.append(normalized)
        if filteredLogs.count > Self.maxLogs {
            filteredLogs.removeFirst(filteredLogs.count - Self.maxLogs)
        }
    }

    private func normalizeIfNeeded(_ line: LogLine) -> LogLine {
        guard line.line.first == "{" else { return line }
        guard let data = line.line.data(using: .utf8) else { return line }

        struct WSLogPayload: Decodable {
            let timestamp: Date?
            let line: String?
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = DateParser.decodingStrategy

        if let payload = try? decoder.decode(WSLogPayload.self, from: data),
           let innerLine = payload.line,
           !innerLine.isEmpty {
            return LogLine(timestamp: payload.timestamp ?? line.timestamp, line: innerLine)
        }

        return line
    }
}
