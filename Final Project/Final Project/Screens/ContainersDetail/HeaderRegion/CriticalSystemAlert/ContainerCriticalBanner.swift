//
//  ContainerCriticalBanner.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerCriticalBanner: View {
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(DS.Color.accent.opacity(0.12))
                    .frame(width: 36, height: 36)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(DS.Color.accent.opacity(0.35), lineWidth: 1.5)
                    )

                Image(systemName: "shield.fill")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(DS.Color.accent)
                    .shadow(color: DS.Color.accent.opacity(0.6), radius: 5)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text("System-Critical Container")
                    .font(DS.Font.headline(13))
                    .foregroundColor(DS.Color.textPrimary)

                Text("lumen-app powers this entire monitoring system. Stop/Restart/Remove are disabled to protect your infrastructure.")
                    .font(DS.Font.caption(11))
                    .foregroundColor(DS.Color.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(14)
        .background(
            ContainerDetailCard(glow: DS.Color.accent, glowStrength: 0.25)
                .shadow(color: DS.Color.accent.opacity(0.1), radius: 12, x: 0, y: 4)
        )
    }
}