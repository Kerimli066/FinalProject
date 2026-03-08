//
//  SettingsSubtitleView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct SettingsSubtitleView: View {
    let appeared: Bool

    var body: some View {
        HStack(spacing: 8) {
            Text("Alerts").foregroundColor(DS.Color.warning.opacity(0.85))
            Text(".").foregroundColor(DS.Color.textTertiary)
            Text("Notifications").foregroundColor(DS.Color.accentSoft.opacity(0.85))
            Text(".").foregroundColor(DS.Color.textTertiary)
            Text("Server").foregroundColor(DS.Color.accent.opacity(0.85))
        }
        .font(.system(size: 13, weight: .medium))
        .padding(.top, 6)
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.45).delay(0.22), value: appeared)
    }
}
