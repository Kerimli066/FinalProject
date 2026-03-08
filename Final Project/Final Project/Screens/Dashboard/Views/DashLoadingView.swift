//
//  DashLoadingView.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

struct DashLoadingView: View {
    let appeared: Bool

    var body: some View {
        VStack(spacing: 18) {
            ZStack {
                Circle()
                    .stroke(DS.Color.accent.opacity(0.12), lineWidth: 2)
                    .frame(width: 56, height: 56)

                Circle()
                    .trim(from: 0, to: 0.65)
                    .stroke(DS.Color.accent, style: StrokeStyle(lineWidth: 2.5, lineCap: .round))
                    .frame(width: 56, height: 56)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1.1).repeatForever(autoreverses: false), value: appeared)

                Image(systemName: "bolt.fill")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(DS.Color.accent)
                    .shadow(color: DS.Color.accent.opacity(0.5), radius: 8)
            }

            Text("Connecting…")
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundColor(DS.Color.textTertiary)
                .tracking(1.5)
        }
    }
}
