//
//  ContainersLiveBadge.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainersLiveBadge: View {
    var body: some View {
        HStack(spacing: 5) {
            PulseDot(color: DS.Color.success, size: 5)

            Text("LIVE")
                .font(DS.Font.label(9))
                .foregroundColor(DS.Color.success)
                .tracking(1.5)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(DS.Color.success.opacity(0.07))
                .overlay(
                    Capsule()
                        .stroke(DS.Color.success.opacity(0.2), lineWidth: 1)
                )
        )
    }
}
