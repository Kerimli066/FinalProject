//
//  Alert.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import Foundation

struct Alert: Identifiable, Hashable, Codable {
    let id: String
    let containerId: String
    let containerName: String
    let type: String
    let message: String
    let value: Double
    let timestamp: Date

    enum CodingKeys: String, CodingKey {
        case id, containerId, containerName, type, message, value, timestamp
    }

    init(
        id: String,
        containerId: String,
        containerName: String,
        type: String,
        message: String,
        value: Double,
        timestamp: Date
    ) {
        self.id = id
        self.containerId = containerId
        self.containerName = containerName
        self.type = type
        self.message = message
        self.value = value
        self.timestamp = timestamp
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)

        id            = try c.decode(String.self, forKey: .id)
        containerId   = try c.decode(String.self, forKey: .containerId)
        containerName = try c.decode(String.self, forKey: .containerName)
        type          = try c.decode(String.self, forKey: .type)
        message       = try c.decode(String.self, forKey: .message)
        value         = try c.decode(Double.self, forKey: .value)

        let tsStr = try c.decode(String.self, forKey: .timestamp)

        timestamp = DateParser.parse(tsStr)!
    }
}

