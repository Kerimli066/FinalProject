//
//  HealthStatus.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//



import SwiftUI

enum HealthStatus: Equatable {
    case healthy, warning, critical

    var label: String {
        switch self {
        case .healthy:  return "Healthy"
        case .warning:  return "Warning"
        case .critical: return "Critical"
        }
    }

    var color: SwiftUI.Color {
        switch self {
        case .healthy:  return DS.Color.success
        case .warning:  return DS.Color.warning
        case .critical: return DS.Color.danger
        }
    }

    static func from(score: Int) -> HealthStatus {
        score >= 70 ? .healthy : score >= 40 ? .warning : .critical
    }
}
