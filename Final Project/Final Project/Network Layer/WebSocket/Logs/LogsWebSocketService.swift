//
//  LogsWebSocketService.swift
//  Final Project
//
//  Created by SabinaKarimli on 14.02.26.
//

import Foundation

final class LogsWebSocketService: LogsStreaming {

    private let client: WebSocketClient
    private let baseHTTP: String
    private let decoder: JSONDecoder

    private struct WSLogPayload: Decodable {
        let timestamp: Date?
        let line: String?
    }

    init(
        baseURL: String = AppConfig.baseURL,
        client: WebSocketClient = DefaultWebSocketClient()
    ) {
        self.baseHTTP = baseURL
        self.client   = client

        let d = JSONDecoder()
        d.dateDecodingStrategy = DateParser.decodingStrategy
        self.decoder = d
    }

    func stream(containerId: String) -> AsyncThrowingStream<LogLine, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                var attempt = 0

                while !Task.isCancelled {
                    do {
                        let url = try WSRoute.logs(baseHTTP: baseHTTP, containerId: containerId)
                        attempt = 0

                        for try await text in client.textStream(url: url, headers: nil) {
                            if Task.isCancelled { break }

                            if let data = text.data(using: .utf8),
                               let payload = try? decoder.decode(WSLogPayload.self, from: data),
                               let line = payload.line, !line.isEmpty {
                                continuation.yield(
                                    LogLine(timestamp: payload.timestamp ?? Date(), line: line)
                                )
                                continue
                            }

                            continuation.yield(LogLine(timestamp: Date(), line: text))
                        }

                        if Task.isCancelled { break }
                        try await WebSocketBackoff.sleep(attempt: attempt)
                        attempt += 1

                    } catch {
                        if Task.isCancelled { break }
                        try? await WebSocketBackoff.sleep(attempt: attempt)
                        attempt += 1
                    }
                }

                continuation.finish()
            }

            continuation.onTermination = { _ in task.cancel() }
        }
    }
}
