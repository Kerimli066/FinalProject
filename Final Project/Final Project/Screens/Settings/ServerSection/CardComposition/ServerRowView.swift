//
//  ServerRowView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct ServerRowView: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let badge: String?
    let badgeColor: Color

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(iconColor.opacity(0.10))
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(iconColor)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(DS.Color.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)

                Text(subtitle)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(DS.Color.textTertiary)
            }

            Spacer()

            if let badge {
                HStack(spacing: 5) {
                    PulseDot(color: badgeColor, size: 5)
                    Text(badge)
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(badgeColor)
                }
                .padding(.horizontal, 9)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(badgeColor.opacity(0.09))
                        .overlay(Capsule().stroke(badgeColor.opacity(0.25), lineWidth: 1))
                )
            }
        }
        .padding(.vertical, 13)
    }
}
