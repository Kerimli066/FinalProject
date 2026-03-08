//
//  PillView.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct PillView: View {
    let text: String
    var icon: String? = nil

    let textColor: Color
    let fillColor: Color
    let strokeColor: Color

    var font: Font = DS.Font.mono(9)
    var paddingH: CGFloat = 6
    var paddingV: CGFloat = 2
    var iconSize: CGFloat = 8
    var iconWeight: Font.Weight = .semibold

    var body: some View {
        HStack(spacing: icon == nil ? 0 : 3) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: iconSize, weight: iconWeight))
                    .foregroundColor(textColor)
            }

            Text(text)
                .font(font)
                .foregroundColor(textColor)
        }
        .padding(.horizontal, paddingH)
        .padding(.vertical, paddingV)
        .background(
            Capsule()
                .fill(fillColor)
                .overlay(
                    Capsule().stroke(strokeColor, lineWidth: 1)
                )
        )
    }
}

extension PillView {
    static func tag(_ text: String) -> PillView {
        PillView(
            text: text,
            icon: nil,
            textColor: DS.Color.accent,
            fillColor: DS.Color.accent.opacity(0.1),
            strokeColor: DS.Color.accent.opacity(0.2),
            font: DS.Font.mono(10)
        )
    }

    static func driver(_ text: String, color: Color) -> PillView {
        PillView(
            text: text,
            icon: nil,
            textColor: color,
            fillColor: color.opacity(0.1),
            strokeColor: color.opacity(0.25),
            font: DS.Font.mono(9)
        )
    }

    static func muted(_ text: String, font: Font = DS.Font.mono(9),
                      paddingH: CGFloat = 6, paddingV: CGFloat = 2) -> PillView {
        PillView(
            text: text,
            icon: nil,
            textColor: DS.Color.textMuted,
            fillColor: DS.Color.bg4,
            strokeColor: DS.Color.cardBorder,
            font: font,
            paddingH: paddingH,
            paddingV: paddingV
        )
    }

    static func success(_ text: String, icon: String) -> PillView {
        PillView(
            text: text,
            icon: icon,
            textColor: DS.Color.success,
            fillColor: DS.Color.success.opacity(0.08),
            strokeColor: DS.Color.success.opacity(0.18),
            font: DS.Font.label(9),
            paddingH: 6,
            paddingV: 2,
            iconSize: 8,
            iconWeight: .bold
        )
    }
}
