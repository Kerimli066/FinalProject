//
//  ContainerCardAvatar.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerCardAvatar: View {
    let iconColor: Color
    let iconSymbol: String
    let isRunning: Bool
    let isSystemCritical: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [iconColor.opacity(0.18), iconColor.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 44, height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(iconColor.opacity(isRunning ? 0.35 : 0.18), lineWidth: 1)
                )

            Image(systemName: iconSymbol)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(iconColor)
                .shadow(color: isRunning ? iconColor.opacity(0.5) : .clear, radius: 6)

            if isSystemCritical {
                Image(systemName: "shield.fill")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(DS.Color.accent)
                    .offset(x: 15, y: -15)
            }
        }
    }
}
