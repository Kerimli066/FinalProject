//
//  AppTheme.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import UIKit

enum AppTheme {

    enum Color {
        static let backgroundPrimary   = UIColor(hex: "#060A16")
        static let backgroundSecondary = UIColor(hex: "#0B1230")

        static let backgroundCard      = UIColor(hex: "#0F1838")
        static let backgroundField     = UIColor(hex: "#18224A")

        static let gradientTop         = UIColor(hex: "#142057")
        static let gradientBottom      = UIColor(hex: "#050816")

        static let accent              = UIColor(hex: "#4F7CFF")
        static let accentIndigo        = UIColor(hex: "#6C63FF")
        static let accentGlow          = UIColor(hex: "#4F7CFF").withAlphaComponent(0.20)

        static let textPrimary         = UIColor.white
        static let textSecondary       = UIColor(hex: "#B6C2E6")
        static let textMuted           = UIColor(hex: "#7782A6")

        // Stroke
        static let stroke              = UIColor(hex: "#24305E")
        static let strokeLight         = UIColor.white.withAlphaComponent(0.10)

        // Status
        static let success             = UIColor(hex: "#22C55E")
        static let error               = UIColor(hex: "#EF4444")
        static let warning             = UIColor(hex: "#F59E0B")

        static let premiumTeal         = UIColor(hex: "#2DD4BF")
    }

    // MARK: Font
    enum Font {
        static func heavy(_ s: CGFloat)    -> UIFont { .systemFont(ofSize: s, weight: .heavy) }
        static func bold(_ s: CGFloat)     -> UIFont { .systemFont(ofSize: s, weight: .bold) }
        static func semibold(_ s: CGFloat) -> UIFont { .systemFont(ofSize: s, weight: .semibold) }
        static func medium(_ s: CGFloat)   -> UIFont { .systemFont(ofSize: s, weight: .medium) }
        static func regular(_ s: CGFloat)  -> UIFont { .systemFont(ofSize: s, weight: .regular) }
        static func mono(_ s: CGFloat)     -> UIFont { .monospacedSystemFont(ofSize: s, weight: .regular) }
    }

    // MARK: Radius
    enum Radius {
        static let small:  CGFloat = 12
        static let medium: CGFloat = 16
        static let large:  CGFloat = 22
        static let card:   CGFloat = 26
    }

    // MARK: Spacing
    enum Spacing {
        static let xs:  CGFloat = 6
        static let sm:  CGFloat = 12
        static let md:  CGFloat = 18
        static let lg:  CGFloat = 24
        static let xl:  CGFloat = 32
        static let xxl: CGFloat = 48
    }

    // MARK: Shadow
    enum Shadow {

        static func accent(on layer: CALayer) {
            colored(AppTheme.Color.accent, on: layer)
        }

        static func card(on layer: CALayer) {
            layer.shadowColor   = UIColor.black.cgColor
            layer.shadowOpacity = 0.28
            layer.shadowRadius  = 20
            layer.shadowOffset  = CGSize(width: 0, height: 12)
        }

        static func subtle(on layer: CALayer) {
            layer.shadowColor   = UIColor.black.cgColor
            layer.shadowOpacity = 0.16
            layer.shadowRadius  = 10
            layer.shadowOffset  = CGSize(width: 0, height: 6)
        }

        static func colored(_ color: UIColor, on layer: CALayer) {
            layer.shadowColor   = color.cgColor
            layer.shadowOpacity = 0.30
            layer.shadowRadius  = 18
            layer.shadowOffset  = CGSize(width: 0, height: 10)
        }
    }
}

