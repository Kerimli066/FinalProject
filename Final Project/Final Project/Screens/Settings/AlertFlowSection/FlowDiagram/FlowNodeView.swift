//
//  FlowNodeView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct FlowNodeView: View {
    let icon: String
    let label: String
    let color: Color
    let appeared: Bool
    let delay: Double

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle().stroke(color.opacity(0.2), lineWidth: 1).frame(width: 48, height: 48)
                Circle().fill(color.opacity(0.12)).frame(width: 42, height: 42)
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(color)
            }

            Text(label)
                .font(.system(size: 9, weight: .bold, design: .monospaced))
                .foregroundColor(DS.Color.textTertiary)
                .tracking(0.5)
        }
        .frame(maxWidth: .infinity)
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 8)
        .animation(.spring(response: 0.5, dampingFraction: 0.7).delay(delay + 0.4), value: appeared)
    }
}
