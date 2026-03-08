//
//  LogLevelStrip.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//



import SwiftUI

struct LogLevelStrip: View {
    let level: LogLevel

    var body: some View {
        Rectangle()
            .fill(color)
    }

    private var color: Color {
        switch level {
        case .error:   return DS.Color.danger.opacity(0.85)
        case .warning: return DS.Color.warning.opacity(0.75)
        case .info:    return DS.Color.accentSoft.opacity(0.5)
        case .debug:   return DS.Color.textMuted.opacity(0.3)
        case .all:     return Color.clear
        }
    }
}
