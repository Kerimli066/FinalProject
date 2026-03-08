//
//  LogsFilterLogic.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import Foundation

@MainActor
final class LogsFilterLogic {

    func filtered(logs: [LogLine], selected: LogLevel) -> [LogLine] {
        guard selected != .all else { return logs }
        return logs.filter { $0.level == selected }
    }

    func count(logs: [LogLine], level: LogLevel) -> Int {
        if level == .all { return logs.count }
        return logs.filter { $0.level == level }.count
    }
}
