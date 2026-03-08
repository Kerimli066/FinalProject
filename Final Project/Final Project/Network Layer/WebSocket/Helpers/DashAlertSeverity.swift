//
//  DashAlertSeverity.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

enum DashAlertSeverity {
    case low
    case medium
    case high
    case critical

    var label: String {
        switch self {
        case .low:      return "LOW"
        case .medium:   return "MEDIUM"
        case .high:     return "HIGH"
        case .critical: return "CRITICAL"
        }
    }

    var color: Color {
        switch self {
        case .low:      return DS.Color.success
        case .medium:   return DS.Color.warning
        case .high:     return DS.Color.alertHigh
        case .critical: return DS.Color.danger
        }
    }

    static func fromStats(type: String, rawValue: Double) -> DashAlertSeverity {
        let percent = rawValue <= 1.0 ? rawValue * 100.0 : rawValue
        return fromPercent(type: type, percent: percent)
    }

    static func fromAlert(type: String, value: Double) -> DashAlertSeverity {
        let percent = value <= 1.0 ? value * 100.0 : value
        return fromPercent(type: type, percent: percent)
    }

    static func from(type: String, value: Double) -> DashAlertSeverity {
        return fromAlert(type: type, value: value)
    }

    private static func fromPercent(type: String, percent: Double) -> DashAlertSeverity {
        switch type.uppercased() {
        case "CPU":
            if percent >= AlertSeverityHelper.Threshold.current   { return .critical }
            if percent >= AlertSeverityHelper.Threshold.cpuMedium { return .high }
            if percent >= 1.0                                      { return .medium }
            return .low

        case "MEMORY":
            if percent >= AlertSeverityHelper.Threshold.memHigh   { return .critical }
            if percent >= AlertSeverityHelper.Threshold.memMedium { return .high }
            if percent >= 1.0                                      { return .medium }
            return .low

        default:
            if percent >= AlertSeverityHelper.Threshold.current   { return .critical }
            if percent >= AlertSeverityHelper.Threshold.cpuMedium { return .high }
            if percent >= 1.0                                      { return .medium }
            return .low
        }
    }
}
