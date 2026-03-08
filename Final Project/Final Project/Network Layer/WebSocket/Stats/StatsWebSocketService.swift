//
//  StatsWebSocketService.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import Foundation

final class StatsWebSocketService: StatsStreaming {

    private let baseHTTP: String
    private let decoder:  JSONDecoder
    private let session:  URLSession

    init(baseURL: String = AppConfig.baseURL, session: URLSession = .shared) {
        self.baseHTTP = baseURL
        self.session  = session

        let d = JSONDecoder()
        d.dateDecodingStrategy = DateParser.decodingStrategy
        self.decoder = d
    }

    func stream(containerId: String, email: String?) -> AsyncThrowingStream<ContainerStats, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                var attempt = 0

                while !Task.isCancelled {
                    do {
                        let url = try WSRoute.stats(
                            baseHTTP: baseHTTP,
                            containerId: containerId,
                            email: email
                        )

                        let ws = session.webSocketTask(with: url)
                        ws.resume()
                        attempt = 0

                        defer { ws.cancel(with: .goingAway, reason: nil) }

                        while !Task.isCancelled {
                            let message = try await ws.receive()

                            let data: Data?
                            switch message {
                            case .data(let d):   data = d
                            case .string(let s): data = s.data(using: .utf8)
                            @unknown default:    data = nil
                            }

                            guard let data else { continue }

                            if let stats = try? decoder.decode(ContainerStats.self, from: data) {
                                continuation.yield(stats)
                            }
                        }

                    } catch {
                        if Task.isCancelled { break }
                        try? await WebSocketBackoff.sleep(attempt: attempt)
                        attempt += 1
                        continue
                    }
                }

                continuation.finish()
            }

            continuation.onTermination = { _ in task.cancel() }
        }
    }
}
