//
//  DSGradient.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

enum DSGradient {
    static let pageBG = LinearGradient(
        colors: [SwiftUI.Color(hex: "#0A1020"), SwiftUI.Color(hex: DSToken.bg0)],
        startPoint: .top, endPoint: .bottom
    )

    static let accent = LinearGradient(
        colors: [SwiftUI.Color(hex: DSToken.accentGlow), SwiftUI.Color(hex: DSToken.accent)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    static let success = LinearGradient(
        colors: [SwiftUI.Color(hex: DSToken.success), SwiftUI.Color(hex: DSToken.successSoft)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    static let danger = LinearGradient(
        colors: [SwiftUI.Color(hex: DSToken.danger), SwiftUI.Color(hex: DSToken.dangerSoft)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    static let cpuCard = LinearGradient(
        colors: [SwiftUI.Color(hex: "#0E1A38"), SwiftUI.Color(hex: DSToken.bg3)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    static let memCard = LinearGradient(
        colors: [SwiftUI.Color(hex: "#160E2A"), SwiftUI.Color(hex: DSToken.bg3)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    static func healthGlow(_ color: SwiftUI.Color) -> RadialGradient {
        RadialGradient(
            colors: [color.opacity(0.22), color.opacity(0.05), .clear],
            center: .center, startRadius: 0, endRadius: 120
        )
    }

    static func cardAccent(_ color: SwiftUI.Color) -> LinearGradient {
        LinearGradient(
            colors: [color.opacity(0.12), .clear],
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
    }
}