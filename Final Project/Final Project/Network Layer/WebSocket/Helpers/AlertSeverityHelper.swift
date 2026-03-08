//
//  AlertSeverityHelper.swift
//  Final Project
//

import Foundation

enum AlertSeverityHelper {


    enum Threshold {
        static let cpuHigh:   Double = 20.0
        static let cpuMedium: Double = 12.0

        static let memHigh:   Double = 80.0
        static let memMedium: Double = 60.0

        static var current: Double {
            get { LocalThresholdStore.loadCPU(default: cpuHigh) }
            set { LocalThresholdStore.saveCPU(newValue) }
        }
    }

    // MARK: - Severity

    static func severity(type: String, value: Double) -> AlertSeverity {
        switch type.uppercased() {
        case "CPU":
            if value >= Threshold.cpuHigh   { return .high }
            if value >= Threshold.cpuMedium { return .medium }
            return .low
        case "MEMORY":
            if value >= Threshold.memHigh   { return .high }
            if value >= Threshold.memMedium { return .medium }
            return .low
        default:
            return .low
        }
    }

    static func isCritical(type: String, value: Double) -> Bool {
        severity(type: type, value: value) == .high
    }
}
