//
//  ConnectionStatusCapsule.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct ConnectionStatusCapsule: View {
    let appeared: Bool
    let color: Color
    let text: String

    var body: some View {
        HStack(spacing: 7) {
            PulseDot(color: color, size: 7)
            Text(text.uppercased())
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundColor(color)
                .tracking(1.0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(color.opacity(0.08))
                .overlay(Capsule().stroke(color.opacity(0.3), lineWidth: 1))
        )
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.4).delay(0.15), value: appeared)
    }
}
