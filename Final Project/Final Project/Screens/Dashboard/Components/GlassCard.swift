//
//  GlassCard.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI


struct GlassCard<Content: View>: View {
    var padding: CGFloat = DS.Space.md
    let content: () -> Content

    var body: some View {
        content()
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: DS.Radius.card)
                    .fill(DS.Color.bg2)
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.Radius.card)
                            .stroke(DS.Color.cardBorder, lineWidth: 1)
                    )
            )
            .shadow(color: .black.opacity(0.45), radius: 24, x: 0, y: 12)
    }
}
