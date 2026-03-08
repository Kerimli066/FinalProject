//
//  DSColor.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

enum DSColor {
    // Backgrounds
    static let bg0 = SwiftUI.Color(hex: DSToken.bg0)
    static let bg1 = SwiftUI.Color(hex: DSToken.bg1)
    static let bg2 = SwiftUI.Color(hex: DSToken.bg2)
    static let bg3 = SwiftUI.Color(hex: DSToken.bg3)
    static let bg4 = SwiftUI.Color(hex: DSToken.bg4)
    static let bg5 = SwiftUI.Color(hex: DSToken.bg5)

    // Text
    static let textPrimary   = SwiftUI.Color.white
    static let textSecondary = SwiftUI.Color(hex: DSToken.textSecondary)
    static let textTertiary  = SwiftUI.Color(hex: DSToken.textTertiary)
    static let textMuted     = SwiftUI.Color(hex: DSToken.textMuted)

    // Accent
    static let accent     = SwiftUI.Color(hex: DSToken.accent)
    static let accentSoft = SwiftUI.Color(hex: DSToken.accentSoft)
    static let accentGlow = SwiftUI.Color(hex: DSToken.accentGlow)

    // Status
    static let success     = SwiftUI.Color(hex: DSToken.success)
    static let successSoft = SwiftUI.Color(hex: DSToken.successSoft)
    static let warning     = SwiftUI.Color(hex: DSToken.warning)
    static let warningSoft = SwiftUI.Color(hex: DSToken.warningSoft)
    static let danger      = SwiftUI.Color(hex: DSToken.danger)
    static let dangerSoft  = SwiftUI.Color(hex: DSToken.dangerSoft)

    // Semantic
    static let cardBorder    = SwiftUI.Color.white.opacity(0.06)
    static let cardBorderAlt = SwiftUI.Color.white.opacity(0.09)
    static let divider       = SwiftUI.Color.white.opacity(0.04)

    // Alerts
    static let alertCritical = SwiftUI.Color(hex: DSToken.alertCritical)
    static let alertHigh     = SwiftUI.Color(hex: DSToken.alertHigh)
    static let alertMedium   = SwiftUI.Color(hex: DSToken.alertMedium)
    static let alertLow      = SwiftUI.Color(hex: DSToken.alertLow)

    // Chart
    static let chartPalette: [SwiftUI.Color] = [
        SwiftUI.Color(hex: DSToken.chart0), SwiftUI.Color(hex: DSToken.chart1),
        SwiftUI.Color(hex: DSToken.chart2), SwiftUI.Color(hex: DSToken.chart3),
        SwiftUI.Color(hex: DSToken.chart4), SwiftUI.Color(hex: DSToken.chart5),
        SwiftUI.Color(hex: DSToken.chart6), SwiftUI.Color(hex: DSToken.chart7),
        SwiftUI.Color(hex: DSToken.chart8), SwiftUI.Color(hex: DSToken.chart9),
        SwiftUI.Color(hex: DSToken.chart10)
    ]
}