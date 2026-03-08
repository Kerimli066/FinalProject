//
//  NotificationsCardView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct NotificationsCardView: View {
    let isLoading: Bool
    @Binding var notificationsEnabled: Bool

    var body: some View {
        GlowCardView(accent: DS.Color.warning) {
            CardHeaderView(title: "NOTIFICATIONS", icon: "bell.badge.fill", color: DS.Color.warning)

            HStack(spacing: 16) {
                NotificationIconBubble(enabled: notificationsEnabled)

                NotificationTextBlock(enabled: notificationsEnabled)

                Spacer()

                if isLoading {
                    ProgressView().scaleEffect(0.85).tint(DS.Color.accent)
                } else {
                    Toggle("", isOn: $notificationsEnabled)
                        .labelsHidden()
                        .tint(DS.Color.accent)
                }
            }
            .padding(.bottom, 4)
        }
    }
}



