//
//  AlertSeverity.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

enum AlertSeverity: String, Equatable {
    case critical
    case high
    case medium
    case low

    var label: String {
        switch self {
        case .critical: return "CRITICAL"
        case .high:     return "HIGH"
        case .medium:   return "MEDIUM"
        case .low:      return "LOW"
        }
    }

    var color: Color {
        switch self {
        case .critical: return DS.Color.alertCritical
        case .high:     return DS.Color.alertHigh
        case .medium:   return DS.Color.alertMedium
        case .low:      return DS.Color.alertLow
        }
    }
}

struct AlertSeverityCalculator {
    static func severity(for alert: Alert) -> AlertSeverity {
        let value = alert.value
        let type  = alert.type.uppercased()

        switch type {
        case "CPU":
            if value >= AlertSeverityHelper.Threshold.cpuHigh   { return .critical } // ≥20%
            if value >= AlertSeverityHelper.Threshold.cpuMedium { return .high }     // ≥12%
            if value >= 1.0                                      { return .medium }   // ≥1%
            return .low

        case "MEMORY":
            if value >= AlertSeverityHelper.Threshold.memHigh   { return .critical } // ≥80%
            if value >= AlertSeverityHelper.Threshold.memMedium { return .high }     // ≥60%
            if value >= 1.0                                      { return .medium }   // ≥1%
            return .low

        default:
            if value >= AlertSeverityHelper.Threshold.cpuHigh   { return .critical }
            if value >= AlertSeverityHelper.Threshold.cpuMedium { return .high }
            if value >= 1.0                                      { return .medium }
            return .low
        }
    }
}
