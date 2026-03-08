//
//  DateParser.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import Foundation

enum DateParser {

    // MARK: - JSONDecoder strategy

    static let decodingStrategy: JSONDecoder.DateDecodingStrategy = .custom { decoder in
        let container = try decoder.singleValueContainer()
        let str = try container.decode(String.self)
        if let date = DateParser.parse(str) { return date }
        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Cannot parse date: \(str)"
        )
    }

    // MARK: - Parse

    static func parse(_ str: String) -> Date? {
        if let date = parseNanoseconds(str) { return date }

        if let date = iso8601ms.date(from: str) { return date }

        if let date = iso8601s.date(from: str) { return date }

        return nil
    }

    private static func parseNanoseconds(_ str: String) -> Date? {
        guard let dotIdx = str.firstIndex(of: ".") else { return nil }
        let afterDot = str.index(after: dotIdx)

        var endIdx = afterDot
        while endIdx < str.endIndex && str[endIdx].isNumber {
            endIdx = str.index(after: endIdx)
        }

        let fracCount = str.distance(from: afterDot, to: endIdx)
        guard fracCount > 3 else { return nil }

        let prefix   = String(str[str.startIndex..<afterDot])
        let fracPart = String(str[afterDot..<endIdx].prefix(3))
        let suffix   = String(str[endIdx...])

        let trimmed = prefix + fracPart + suffix
        return iso8601ms.date(from: trimmed)
    }

    private static let iso8601ms: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()

    private static let iso8601s: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime]
        return f
    }()
}
