//
//  WSRoute.swift
//  Final Project
//
//  Created by SabinaKarimli on 13.02.26.
//

import Foundation

enum WSRoute {

    static func stats(baseHTTP: String, containerId: String, email: String?) throws -> URL {
        try makeWSURL(baseHTTP: baseHTTP, path: "/stats", query: [
            URLQueryItem(name: "containerId", value: containerId),
            URLQueryItem(name: "email", value: email?.trimmedNonEmpty)
        ].compactQueryItems)
    }

    static func logs(baseHTTP: String, containerId: String) throws -> URL {
        try makeWSURL(baseHTTP: baseHTTP, path: "/logs", query: [
            URLQueryItem(name: "containerId", value: containerId)
        ])
    }

    static func makeWSURL(baseHTTP: String, path: String, query: [URLQueryItem]) throws -> URL {
        guard var components = URLComponents(string: baseHTTP) else { throw URLError(.badURL) }

        switch components.scheme?.lowercased() {
        case "http":  components.scheme = "ws"
        case "https": components.scheme = "wss"
        case "ws", "wss": break
        default: throw URLError(.badURL)
        }

        let p = path.hasPrefix("/") ? path : "/" + path
        components.path = p
        components.queryItems = query.isEmpty ? nil : query

        guard let url = components.url else { throw URLError(.badURL) }
        return url
    }
}

private extension String {
    var trimmedNonEmpty: String? {
        let t = trimmingCharacters(in: .whitespacesAndNewlines)
        return t.isEmpty ? nil : t
    }
}

private extension Array where Element == URLQueryItem {
    var compactQueryItems: [URLQueryItem] {
        self.filter { !($0.value?.isEmpty ?? true) }
    }
}
