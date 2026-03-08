//
//  AlertsLoadingView.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct AlertsLoadingView: View {
    let appeared: Bool

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                ZStack {
                    Circle()
                        .stroke(DS.Color.danger.opacity(0.12), lineWidth: 2)
                        .frame(width: 52, height: 52)

                    Circle()
                        .trim(from: 0, to: 0.65)
                        .stroke(DS.Color.danger, style: StrokeStyle(lineWidth: 2.5, lineCap: .round))
                        .frame(width: 52, height: 52)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1.1).repeatForever(autoreverses: false),
                                   value: appeared)

                    Image(systemName: "bell.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(DS.Color.danger.opacity(0.8))
                }

                Text("Loading alerts…")
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                    .foregroundColor(DS.Color.textTertiary)
                    .tracking(1.0)
            }
            Spacer()
        }
    }
}