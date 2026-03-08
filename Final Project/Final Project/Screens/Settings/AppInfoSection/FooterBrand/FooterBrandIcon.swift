//
//  FooterBrandIcon.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct FooterBrandIcon: View {
    var body: some View {
        ZStack {
            Circle().stroke(DS.Color.accent.opacity(0.06), lineWidth: 1).frame(width: 100, height: 100)
            Circle().stroke(DS.Color.accent.opacity(0.12), lineWidth: 1).frame(width: 80, height: 80)
            Circle().fill(DS.Color.accent.opacity(0.12)).frame(width: 70, height: 70).blur(radius: 14)

            RoundedRectangle(cornerRadius: 22)
                .fill(
                    LinearGradient(
                        colors: [DS.Color.accentGlow, DS.Color.accent],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 64, height: 64)
                .shadow(color: DS.Color.accent.opacity(0.6), radius: 22, x: 0, y: 8)

            Image(systemName: "bolt.fill")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.5), radius: 5)
        }
    }
}
