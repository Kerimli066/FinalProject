//
//  PremiumRowShell.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct PremiumRowShell<Content: View>: View {
    let index: Int
    let accent: Color
    @ViewBuilder let content: () -> Content

    @State private var appeared = false

    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [accent, accent.opacity(0.2)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 3)
                .padding(.vertical, 10)

            HStack(spacing: 12) {
                content()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 11)
        }
        .opacity(appeared ? 1 : 0)
        .offset(x: appeared ? 0 : -8)
        .onAppear {
            withAnimation(DS.Anim.smooth.delay(Double(index) * 0.03)) { appeared = true }
        }
    }
}
