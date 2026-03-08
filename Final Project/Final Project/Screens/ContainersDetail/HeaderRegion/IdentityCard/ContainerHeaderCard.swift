//
//  ContainerHeaderCard.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerHeaderCard: View {
    let container: ContainerInfo
    let isSystemCritical: Bool

    private var statusColor: Color {
        container.isRunning
            ? (isSystemCritical ? DS.Color.accent : DS.Color.success)
            : DS.Color.textTertiary
    }

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: DS.Radius.sm)
                    .fill(statusColor.opacity(0.1))
                    .frame(width: 56, height: 56)
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.Radius.sm)
                            .stroke(
                                statusColor.opacity(isSystemCritical ? 0.4 : 0.25),
                                lineWidth: isSystemCritical ? 1.5 : 1
                            )
                    )

                Image(systemName: ContainerCardIconStyle.symbol(for: container.image))


                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(statusColor)
                    .shadow(color: statusColor.opacity(0.5), radius: 7)
            }
            .shadow(color: container.isRunning ? statusColor.opacity(0.18) : .clear, radius: 14)

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 6) {
                    Text(container.name)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(DS.Color.textPrimary)
                        .lineLimit(1)

                    if isSystemCritical {
                        Image(systemName: "shield.fill")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(DS.Color.accent)
                    }
                }

                Text(container.image)
                    .font(DS.Font.mono(11))
                    .foregroundColor(DS.Color.textTertiary)
                    .lineLimit(1)

                HStack(spacing: 8) {
                    ContainerStateBadge(state: container.state, isRunning: container.isRunning)
                    Text(container.status)
                        .font(DS.Font.caption(11))
                        .foregroundColor(DS.Color.textTertiary)
                        .lineLimit(1)
                }
            }

            Spacer()
        }
        .padding(DS.Space.sm)
        .background(ContainerDetailCard(glow: statusColor))
    }
}
