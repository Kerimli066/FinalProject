//
//  ContainerDetailCard.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerDetailCard: View {
    var glow: Color?
    var glowStrength: Double = 0.05

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DS.Radius.lg)
                .fill(DS.Color.bg2)

            if let g = glow {
                RoundedRectangle(cornerRadius: DS.Radius.lg)
                    .fill(
                        LinearGradient(
                            colors: [g.opacity(glowStrength), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }

            RoundedRectangle(cornerRadius: DS.Radius.lg)
                .stroke(
                    LinearGradient(
                        colors: [
                            (glow ?? DS.Color.cardBorder).opacity(glow != nil ? 0.2 : 0.06),
                            DS.Color.cardBorder
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        }
        .shadow(color: .black.opacity(0.38), radius: 18, x: 0, y: 7)
    }
}