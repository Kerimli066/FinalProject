//
//  FooterBrandTexts.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct FooterBrandTexts: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("Pocket Lumen")
                .font(.system(size: 18, weight: .black, design: .rounded))
                .foregroundColor(DS.Color.textPrimary)

            Text("Real-time Docker monitoring for iOS")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(DS.Color.textTertiary)

            HStack(spacing: 6) {
                Circle().fill(DS.Color.success).frame(width: 5, height: 5)
                Text("v2.0.0 PRO")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(DS.Color.accent.opacity(0.8))
                    .tracking(0.8)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(DS.Color.bg1)
                    .overlay(Capsule().stroke(DS.Color.accent.opacity(0.18), lineWidth: 1))
            )
            .padding(.top, 2)
        }
    }
}
