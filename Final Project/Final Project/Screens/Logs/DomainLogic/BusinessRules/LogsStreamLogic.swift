//
//  LogsStreamLogic.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import Foundation

@MainActor
final class LogsStreamLogic {

    private var streamTask: Task<Void, Never>?
    private var pendingLogs: [LogLine] = []

    var streamAttempt: Int = 0
    private let maxAttempts: Int = 6

    private(set) var userStopped: Bool = false

    var hasActiveTask: Bool { streamTask != nil }
    var exceededMaxAttempts: Bool { streamAttempt > maxAttempts }

    func startTask(_ work: @escaping () async -> Void) {
        streamTask = Task { await work() }
    }

    func finishTask() {
        streamTask = nil
    }

    func cancelTask() {
        streamTask?.cancel()
        streamTask = nil
    }

    func markUserStop() { userStopped = true }
    func markAutoStopAllowed() { userStopped = false }
    func resetAttempts() { streamAttempt = 0 }
    func bumpAttempt() { streamAttempt += 1 }

    func pushPending(_ line: LogLine) {
        pendingLogs.append(line)
        if pendingLogs.count > 1500 {
            pendingLogs.removeFirst(pendingLogs.count - 1500)
        }
    }

    func clearPending() {
        pendingLogs.removeAll()
    }

    func drainPending() -> [LogLine] {
        let out = pendingLogs
        pendingLogs.removeAll()
        return out
    }
}
