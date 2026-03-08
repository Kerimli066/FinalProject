//
//  TerminalRowBackground.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct TerminalRowBackground: View {
    let level: LogLevel
    let lineNumber: Int

    var body: some View {
        Group {
            switch level {
            case .error:
                DS.Color.danger.opacity(0.05)
            case .warning:
                DS.Color.warning.opacity(0.035)
            default:
                (lineNumber % 2 == 0) ? Color.white.opacity(0.006) : Color.clear
            }
        }
    }
}
