//
//  ContainerPickerCardBackground.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct ContainerPickerCardBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(DS.Color.bg2)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        LinearGradient(
                            colors: [
                                DS.Color.accent.opacity(0.2),
                                DS.Color.cardBorder.opacity(0.4)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: DS.Color.accent.opacity(0.06), radius: 12, x: 0, y: 4)
    }
}

