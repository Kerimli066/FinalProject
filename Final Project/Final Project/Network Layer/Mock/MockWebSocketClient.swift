//
//  MockWebSocketClient.swift
//  Final Project
//
//  Created by SabinaKarimli on 12.02.26.
//


import Foundation

final class MockWebSocketClient: WebSocketClient {

    private var isClosed = false

    func textStream(url: URL, headers: [String : String]?) -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                var tick = 0
                while !Task.isCancelled && !self.isClosed {
                    tick += 1
                    continuation.yield("mock-line \(tick) from \(url.lastPathComponent)")
                    try? await Task.sleep(nanoseconds: 300_000_000)
                }
                continuation.finish()
            }
            continuation.onTermination = { _ in task.cancel() }
        }
    }

    func close() { isClosed = true }
}
