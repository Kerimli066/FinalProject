//
//  MockLogsHub.swift
//  Final Project
//
//  Created by SabinaKarimli on 12.02.26.
//

import Foundation

final class MockLogsHub: LogsStreaming {

    private static let lines: [String] = [
        "[INFO] Server started on port 8080",
        "[DEBUG] Processing request id=a3f8b2c1",
        "[INFO] GET /health 200 OK",
        "[WARN] High memory usage detected: 78%",
        "[ERROR] Connection timeout after 30s",
        "[DEBUG] Cache miss for key=session_data",
        "[INFO] POST /api/start 200 OK",
        "[ERROR] Failed to connect to database: connection refused",
        "[WARN] Retry attempt 2/3 for endpoint /metrics",
        "[INFO] Container health check passed",
        "[DEBUG] Flushing log buffer: 128 entries",
        "[INFO] Scheduled task completed in 142ms",
        "[ERROR] Out of memory: killed process 1847",
        "[WARN] Disk usage at 91%, threshold is 90%",
        "[DEBUG] GC pause: 18ms",
        "[INFO] New connection from 172.18.0.3",
        "[ERROR] Unhandled exception in worker thread",
        "[INFO] Config reloaded successfully",
        "[DEBUG] Query executed in 4ms: SELECT * FROM containers",
        "[WARN] Timeout waiting for lock on resource=db_write"
    ]

    private struct MockPayload: Encodable {
        let timestamp: String
        let line: String
    }

    private static let isoFormatter: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()

    func stream(containerId: String) -> AsyncThrowingStream<LogLine, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                var i = 0

                while !Task.isCancelled {
                    let payload = MockPayload(
                        timestamp: Self.isoFormatter.string(from: Date()),
                        line: "[\(containerId)] \(Self.lines[i % Self.lines.count])"
                    )

                    if let data = try? JSONEncoder().encode(payload),
                       let text = String(data: data, encoding: .utf8) {
                        continuation.yield(LogLine(timestamp: Date(), line: text))
                    } else {
                        continuation.yield(
                            LogLine(timestamp: Date(), line: "[\(containerId)] \(Self.lines[i % Self.lines.count])")
                        )
                    }

                    i += 1
                    try? await Task.sleep(nanoseconds: 700_000_000)
                }

                continuation.finish()
            }

            continuation.onTermination = { _ in task.cancel() }
        }
    }
}
