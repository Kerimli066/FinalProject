//
//  CardModifier.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import SwiftUI
struct CardModifier: ViewModifier {
    var radius:  CGFloat
    var glow:    Color?
    var pressed: Bool

    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: radius)
                        .fill(DS.Color.bg2)
                    if let g = glow {
                        RoundedRectangle(cornerRadius: radius)
                            .fill(LinearGradient(
                                colors: [g.opacity(0.07), Color.clear],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            ))
                    }
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(glow?.opacity(0.22) ?? DS.Color.cardBorder, lineWidth: 1)
                }
                .shadow(
                    color: .black.opacity(pressed ? 0.1 : 0.4),
                    radius: pressed ? 3 : 22, x: 0, y: pressed ? 1 : 9
                )
            )
            .scaleEffect(pressed ? 0.979 : 1)
            .animation(DS.Anim.fast, value: pressed)
    }
}

extension View {
    func proCard(
        radius: CGFloat = DS.Radius.lg,
        glow: Color? = nil,
        pressed: Bool = false
    ) -> some View {
        modifier(CardModifier(radius: radius, glow: glow, pressed: pressed))
    }

    
}


