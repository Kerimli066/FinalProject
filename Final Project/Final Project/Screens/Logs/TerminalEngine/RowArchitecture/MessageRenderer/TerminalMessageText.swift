//
//  TerminalMessageText.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct TerminalMessageText: View {
    let text: String
    let level: LogLevel

    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .regular, design: .monospaced))
            .foregroundColor(color)
            .lineLimit(nil)
            .textSelection(.enabled)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 6)
            .padding(.trailing, 12)
    }

    private var color: Color {
        switch level {
        case .error:   return DS.Color.danger.opacity(0.9)
        case .warning: return DS.Color.warning.opacity(0.9)
        case .info:    return DS.Color.textSecondary
        case .debug:   return DS.Color.textTertiary
        case .all:     return DS.Color.textSecondary
        }
    }
}
