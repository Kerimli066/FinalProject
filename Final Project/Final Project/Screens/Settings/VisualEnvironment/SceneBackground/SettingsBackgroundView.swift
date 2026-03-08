//
//  SettingsBackgroundView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct SettingsBackgroundView: View {
    var body: some View {
        ZStack {
            DS.Color.bg0.ignoresSafeArea()

            RadialGradient(
                gradient: Gradient(colors: [DS.Color.accent.opacity(0.12), DS.Color.bg0.opacity(0)]),
                center: .init(x: 0.85, y: 0.05),
                startRadius: 0, endRadius: 420
            )
            .ignoresSafeArea()
            .allowsHitTesting(false)
        }
    }
}