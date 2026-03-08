//
//  WebSocketBackoff.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//



import Foundation

enum WebSocketBackoff {

    static func sleep(attempt: Int) async throws {
        let base   = min(10.0, 0.5 * pow(2.0, Double(min(attempt, 6))))
        let jitter = Double.random(in: 0...0.25)
        try await Task.sleep(nanoseconds: UInt64((base + jitter) * 1_000_000_000))
    }
}
