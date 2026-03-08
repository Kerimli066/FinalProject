//
//  AlertFilterType.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

enum AlertFilterType: String, CaseIterable {
    case all      = "All"
    case critical = "Critical"
    case high     = "High"
    case medium   = "Medium"

    var label: String { rawValue }

    var icon: String {
        switch self {
        case .all:      return "list.bullet"
        case .critical: return "exclamationmark.triangle.fill"
        case .high:     return "exclamationmark.circle.fill"
        case .medium:   return "minus.circle.fill"
        }
    }

    var accentColor: Color {
        switch self {
        case .all:      return DS.Color.accent
        case .critical: return DS.Color.alertCritical
        case .high:     return DS.Color.alertHigh
        case .medium:   return DS.Color.alertMedium
        }
    }
}