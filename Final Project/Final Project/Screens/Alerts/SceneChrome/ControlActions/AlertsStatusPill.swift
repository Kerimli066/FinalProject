//
//  AlertsStatusPill.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct AlertsStatusPill: View {
    let isLoading: Bool

    var body: some View {
        let color = isLoading ? DS.Color.accent : DS.Color.success

        HStack(spacing: 7) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(color)
                    .frame(width: 6, height: 6)
            }

            Text(isLoading ? "SYNCING" : "ACTIVE")
                .font(.system(size: 10, weight: .black, design: .monospaced))
                .foregroundColor(color)
                .tracking(2.5)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 7)
        .background(
            Capsule()
                .fill(color.opacity(0.07))
                .overlay(Capsule().stroke(color.opacity(0.2), lineWidth: 1))
        )
        .animation(DS.Anim.smooth, value: isLoading)
    }
}