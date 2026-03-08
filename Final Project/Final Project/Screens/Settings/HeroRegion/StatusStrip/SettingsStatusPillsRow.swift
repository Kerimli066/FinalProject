//
//  SettingsStatusPillsRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct SettingsStatusPillsRow: View {
    let appeared: Bool
    let notificationsEnabled: Bool

    var body: some View {
        HStack(spacing: 10) {
            StatusPillView(
                label: "ALERTS",
                value: notificationsEnabled ? "ENABLED" : "DISABLED",
                icon: notificationsEnabled ? "bell.fill" : "bell.slash.fill",
                color: notificationsEnabled ? DS.Color.success : DS.Color.textTertiary
            )

            StatusPillView(
                label: "DATA",
                value: AppConfig.useMock ? "MOCK" : "LIVE",
                icon: "waveform",
                color: AppConfig.useMock ? DS.Color.warning : DS.Color.success
            )

            StatusPillView(
                label: "HOST",
                value: PrettyHostFormatter.prettyHost(from: AppConfig.baseURL),
                icon: "server.rack",
                color: DS.Color.accent.opacity(0.8)
            )
        }
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.4).delay(0.28), value: appeared)
    }
}
