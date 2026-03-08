//
//  DashboardCoordinator.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import Foundation
import FirebaseAuth

final class DashboardCoordinator {

    // MARK: - Callbacks

    var onContainersFetched: (@MainActor ([ContainerInfo]) -> Void)?
    var onAlertsFetched:     (@MainActor ([Alert]) -> Void)?
    var onStatsReceived:     (@MainActor (ContainerStats, String) -> Void)?
    var onSnapshotTick:      (@MainActor () -> Void)?
    var onError:             (@MainActor (String) -> Void)?

    // MARK: - Private

    private let service: LumenService
    private let statsStreaming: StatsStreaming

    private var streamTasks:    [String: Task<Void, Never>] = [:]
    private var snapshotTimer:  Task<Void, Never>?
    private var alertTimer:     Task<Void, Never>?
    private var containerTimer: Task<Void, Never>?

    private var sessionID: UUID = UUID()

    // MARK: - Init / Deinit

    init(service: LumenService, statsStreaming: StatsStreaming) {
        self.service = service
        self.statsStreaming = statsStreaming
    }

    deinit {
        cancelAllTasks()
    }


    @MainActor
    func startInitialLoad() {
        sessionID = UUID()
        let sid = sessionID
        Task { [weak self] in
            await self?.loadInitial(sessionID: sid)
        }
    }

    @MainActor
    func stopAll() {
        cancelAllTasks()
        streamTasks.removeAll()
        snapshotTimer = nil
        alertTimer = nil
        containerTimer = nil
    }


    private func cancelAllTasks() {
        streamTasks.values.forEach { $0.cancel() }
        snapshotTimer?.cancel()
        alertTimer?.cancel()
        containerTimer?.cancel()
    }

    // MARK: - Initial Load

    private func loadInitial(sessionID: UUID) async {
        guard await isCurrentSession(sessionID) else { return }

        do {
            async let cTask = service.listContainers()
            async let aTask = service.getAlertHistory()
            let (containers, alerts) = try await (cTask, aTask)

            guard await isCurrentSession(sessionID) else { return }

            await onContainersFetched?(containers)
            await onAlertsFetched?(alerts)
            await syncStreams(with: containers, sessionID: sessionID)
            await startTimers(sessionID: sessionID)

        } catch {
            guard await isCurrentSession(sessionID) else { return }
            await onError?(error.localizedDescription)
        }
    }

    @MainActor
    private func isCurrentSession(_ id: UUID) -> Bool { sessionID == id }

    // MARK: - Timers

    @MainActor
    private func startTimers(sessionID: UUID) {
        startSnapshotTimer(sessionID: sessionID)
        startAlertTimer(sessionID: sessionID)
        startContainerRefreshTimer(sessionID: sessionID)
    }

    @MainActor
    private func startSnapshotTimer(sessionID: UUID) {
        snapshotTimer?.cancel()
        snapshotTimer = Task { [weak self] in
            while !Task.isCancelled {
                do { try await Task.sleep(nanoseconds: UInt64(DashboardConstants.snapshotInterval * 1_000_000_000)) }
                catch { break }
                guard let self, !Task.isCancelled,  self.isCurrentSession(sessionID) else { break }
                 self.onSnapshotTick?()
            }
        }
    }

    @MainActor
    private func startAlertTimer(sessionID: UUID) {
        alertTimer?.cancel()
        alertTimer = Task { [weak self] in
            while !Task.isCancelled {
                do { try await Task.sleep(nanoseconds: UInt64(DashboardConstants.alertRefreshInterval * 1_000_000_000)) }
                catch { break }
                guard let self, !Task.isCancelled,  self.isCurrentSession(sessionID) else { break }
                guard let alerts = try? await self.service.getAlertHistory() else { continue }
                guard  self.isCurrentSession(sessionID) else { break }
                 self.onAlertsFetched?(alerts)
            }
        }
    }

    @MainActor
    private func startContainerRefreshTimer(sessionID: UUID) {
        containerTimer?.cancel()
        containerTimer = Task { [weak self] in
            while !Task.isCancelled {
                do { try await Task.sleep(nanoseconds: UInt64(DashboardConstants.containerSyncInterval * 1_000_000_000)) }
                catch { break }
                guard let self, !Task.isCancelled,  self.isCurrentSession(sessionID) else { break }
                guard let containers = try? await self.service.listContainers() else { continue }
                guard self.isCurrentSession(sessionID) else { break }
                self.onContainersFetched?(containers)
                self.syncStreams(with: containers, sessionID: sessionID)
            }
        }
    }

    // MARK: - Stream Sync

    @MainActor
    private func syncStreams(with containers: [ContainerInfo], sessionID: UUID) {
        let runningIDs = Set(containers.filter { $0.isRunning }.map(\.id))
        let knownIDs   = Set(streamTasks.keys)

        for id in knownIDs.subtracting(runningIDs) {
            streamTasks[id]?.cancel()
            streamTasks[id] = nil
        }

        let email = Auth.auth().currentUser?.email
        for id in runningIDs.subtracting(knownIDs) {
            startStream(containerId: id, email: email, sessionID: sessionID)
        }
    }

    @MainActor
    private func startStream(containerId: String, email: String?, sessionID: UUID) {
        let streaming = statsStreaming
        streamTasks[containerId] = Task { [weak self] in
            do {
                for try await stats in streaming.stream(containerId: containerId, email: email) {
                    guard !Task.isCancelled, let self else { break }
                    guard  self.isCurrentSession(sessionID) else { break }
                     self.onStatsReceived?(stats, containerId)
                }
            } catch { }
        }
    }
}
