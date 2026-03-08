//
//  StatsStreamViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import Foundation

@MainActor
final class StatsStreamViewModel: ObservableObject {

    @Published private(set) var connectionState: WebSocketState = .idle
    @Published private(set) var isOfflineFallback: Bool = false
    @Published private(set) var cachedAtText: String? = nil
    @Published private(set) var stats: ContainerStats? = nil

    var cpuPercent: Double {
        guard let v = stats?.cpuUsage else { return 0 }
        let percent = v <= 1.0 ? v * 100.0 : v
        return clampPercent(percent)
    }

    var memPercent: Double {
        guard let s = stats else { return 0 }

        if s.memoryLimit > 0 {
            let computed = Double(s.memoryUsage) / Double(s.memoryLimit) * 100.0
            if computed.isFinite {
                return clampPercent(computed)
            }
        }

        let raw = s.memoryPercent
        let percent = raw <= 1.0 ? raw * 100.0 : raw
        return clampPercent(percent)
    }
    
    var memUsedMB: Double {
        Double(stats?.memoryUsage ?? 0) / 1024.0 / 1024.0
    }

    var memLimitMB: Double {
        Double(stats?.memoryLimit ?? 0) / 1024.0 / 1024.0
    }

    private let streaming: StatsStreaming
    private let cache: StatsCache

    private var streamTask: Task<Void, Never>?
    private var watchdogTask: Task<Void, Never>?

    private var containerId: String?
    private var email: String?

    private var lastPacketAt: Date?
    private var didReceiveAnyPacket = false

    private enum StreamPhase {
        case idle
        case connecting
        case streaming
        case finished
    }

    private var streamPhase: StreamPhase = .idle

    private let noDataTimeoutSeconds: TimeInterval = 8.0
    private let watchdogTickNanos: UInt64 = 1_000_000_000

    init(
        streaming: StatsStreaming = AppEnvironment.makeStatsStreaming(),
        cache: StatsCache = .shared
    ) {
        self.streaming = streaming
        self.cache = cache
    }

    func start(containerId: String, email: String?) {
        stop()

        self.containerId = containerId
        self.email = email

        showCachedIfAvailable(containerId: containerId)

        connectionState = .connecting
        isOfflineFallback = stats != nil
        didReceiveAnyPacket = false
        lastPacketAt = nil
        streamPhase = .connecting

        startWatchdog()

        streamTask = Task { [weak self] in
            guard let self else { return }

            do {
                for try await s in streaming.stream(containerId: containerId, email: email) {
                    if Task.isCancelled { break }

                    if !didReceiveAnyPacket {
                        didReceiveAnyPacket = true
                        streamPhase = .streaming
                    }

                    lastPacketAt = Date()
                    connectionState = .connected
                    isOfflineFallback = false
                    cachedAtText = nil
                    stats = s

                    cache.save(stats: s, containerIdKey: containerId)
                }

                if !Task.isCancelled {
                    streamPhase = .finished
                    connectionState = .disconnected(reason: "Stream ended")
                    fallbackToCache(reason: "Stream ended")
                }

            } catch {
                if Task.isCancelled { return }
                streamPhase = .finished
                connectionState = .disconnected(reason: error.localizedDescription)
                fallbackToCache(reason: error.localizedDescription)
            }
        }
    }

    func stop() {
        streamTask?.cancel()
        streamTask = nil

        watchdogTask?.cancel()
        watchdogTask = nil

        containerId = nil
        email = nil
        lastPacketAt = nil
        didReceiveAnyPacket = false
        streamPhase = .idle

        connectionState = .idle
        isOfflineFallback = false
        cachedAtText = nil
        stats = nil
    }

    private func startWatchdog() {
        watchdogTask?.cancel()

        watchdogTask = Task { [weak self] in
            guard let self else { return }

            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: watchdogTickNanos)
                if Task.isCancelled { break }

                guard streamPhase == .streaming else { continue }
                guard let last = lastPacketAt else { continue }

                let delta = Date().timeIntervalSince(last)
                guard delta >= noDataTimeoutSeconds else { continue }

                connectionState = .disconnected(reason: "No data (\(Int(delta))s)")
                isOfflineFallback = true

                if stats == nil {
                    fallbackToCache(reason: "No data (timeout)")
                }
            }
        }
    }

    private func showCachedIfAvailable(containerId: String) {
        guard let cached = cache.load(containerId: containerId) else { return }
        stats = cached.stats
        isOfflineFallback = true
        cachedAtText = formatCacheDate(cached.cachedAt)
    }

    private func fallbackToCache(reason: String) {
        guard let containerId else {
            connectionState = .failed(error: reason)
            return
        }

        if let cached = cache.load(containerId: containerId) {
            stats = cached.stats
            isOfflineFallback = true
            cachedAtText = formatCacheDate(cached.cachedAt)
            connectionState = .disconnected(reason: reason)
        } else {
            isOfflineFallback = false
            cachedAtText = nil
            connectionState = .failed(error: reason)
        }
    }

    private func formatCacheDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .none
        f.timeStyle = .medium
        return f.string(from: date)
    }

    private func clampPercent(_ value: Double) -> Double {
        min(max(value, 0), 100)
    }
}
