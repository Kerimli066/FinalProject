//
//  SettingsHeroIcon.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct SettingsHeroIcon: View {
    let appeared: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(LinearGradient(
                    colors: [DS.Color.accentGlow, DS.Color.accent],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                ))
                .frame(width: 52, height: 52)
                .shadow(color: DS.Color.accent.opacity(0.7), radius: 18, x: 0, y: 6)

            Image(systemName: "bolt.fill")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
        }
        .opacity(appeared ? 1 : 0)
        .scaleEffect(appeared ? 1 : 0.7)
        .animation(.spring(response: 0.5, dampingFraction: 0.65).delay(0.05), value: appeared)
    }
}
