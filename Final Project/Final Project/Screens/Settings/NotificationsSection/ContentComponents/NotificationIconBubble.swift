//
//  NotificationIconBubble.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct NotificationIconBubble: View {
    let enabled: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(DS.Color.warning.opacity(enabled ? 0.18 : 0.08))
                .frame(width: 52, height: 52)
                .overlay(
                    Circle().stroke(
                        DS.Color.warning.opacity(enabled ? 0.3 : 0.1),
                        lineWidth: 1
                    )
                )
                .animation(DS.Anim.spring, value: enabled)

            Image(systemName: enabled ? "bell.fill" : "bell.slash.fill")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(DS.Color.warning)
                .animation(DS.Anim.spring, value: enabled)
        }
    }
}
