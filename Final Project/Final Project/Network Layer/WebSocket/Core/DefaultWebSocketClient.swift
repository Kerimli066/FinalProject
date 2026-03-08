//
//  DefaultWebSocketClient.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.03.26.
//

import Foundation

final class DefaultWebSocketClient: WebSocketClient {

    private let session: URLSession
    private var task: URLSessionWebSocketTask?

    init(session: URLSession = .shared) {
        self.session = session
    }

    func textStream(url: URL, headers: [String : String]? = nil) -> AsyncThrowingStream<String, Error> {

        var request = URLRequest(url: url)
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        let t = session.webSocketTask(with: request)
        self.task = t
        t.resume()

        return AsyncThrowingStream { continuation in
            func receive() {
                t.receive { result in
                    switch result {
                    case .failure(let err):
                        continuation.finish(throwing: err)

                    case .success(let msg):
                        switch msg {
                        case .string(let str):
                            continuation.yield(str)

                        case .data(let data):
                            if let str = String(data: data, encoding: .utf8) {
                                continuation.yield(str)
                            }

                        @unknown default:
                            break
                        }
                        receive()
                    }
                }
            }

            receive()

            continuation.onTermination = { _ in
                t.cancel(with: .goingAway, reason: nil)
            }
        }
    }

    func close() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
    }
}
