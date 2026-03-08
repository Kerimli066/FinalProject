//
//  PremiumIconBox.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct PremiumIconBox: View {
    let accent: Color
    let systemName: String
    var glow: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .fill(
                    LinearGradient(
                        colors: [accent.opacity(0.14), accent.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 40, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(accent.opacity(0.25), lineWidth: 1)
                )

            Image(systemName: systemName)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(accent)
                .shadow(color: glow ? accent.opacity(0.4) : .clear, radius: 5)
        }
    }
}
