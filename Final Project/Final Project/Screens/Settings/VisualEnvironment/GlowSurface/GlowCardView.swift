//
//  GlowCardView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct GlowCardView<Content: View>: View {
    let accent: Color
    @ViewBuilder let content: () -> Content

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 24)
                .fill(DS.Color.bg1)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            LinearGradient(
                                colors: [accent.opacity(0.25), DS.Color.cardBorder, DS.Color.cardBorder],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: accent.opacity(0.06), radius: 24, x: 0, y: 8)
                .shadow(color: .black.opacity(0.18), radius: 8, x: 0, y: 2)

            Circle()
                .fill(accent.opacity(0.10))
                .frame(width: 120, height: 120)
                .blur(radius: 30)
                .offset(x: 30, y: -30)

            VStack(spacing: 0) { content() }
                .padding(22)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 14)
    }
}


