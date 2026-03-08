//
//  LogLine.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import Foundation

struct LogLine: Identifiable {
    let id        = UUID()
    let timestamp: Date
    let line:      String
    let level:     LogLevel

    init(timestamp: Date, line: String) {
        self.timestamp = timestamp
        self.line      = line
        self.level     = LogLevel.detect(from: line)
    }
}
