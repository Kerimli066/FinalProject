//
//  SettingsHeroModeLabels.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct SettingsHeroModeLabels: View {
    let appeared: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("POCKET LUMEN")
                .font(.system(size: 11, weight: .black, design: .monospaced))
                .foregroundColor(DS.Color.accent)
                .tracking(2.5)

            Text(AppConfig.useMock ? "DEMO MODE" : "LIVE MODE")
                .font(.system(size: 9, weight: .medium, design: .monospaced))
                .foregroundColor(AppConfig.useMock ? DS.Color.warning.opacity(0.7) : DS.Color.success.opacity(0.7))
                .tracking(1.5)
        }
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.4).delay(0.1), value: appeared)
    }
}
