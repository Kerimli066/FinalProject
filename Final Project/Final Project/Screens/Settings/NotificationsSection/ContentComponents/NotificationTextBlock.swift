//
//  NotificationTextBlock.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct NotificationTextBlock: View {
    let enabled: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Enable Alerts")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(DS.Color.textPrimary)

            HStack(spacing: 6) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(enabled ? DS.Color.success : DS.Color.textTertiary)
                    .frame(width: 20, height: 3)

                Text(enabled ? "System monitoring active" : "Alerts paused")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(enabled ? DS.Color.success : DS.Color.textTertiary)
            }
        }
    }
}
