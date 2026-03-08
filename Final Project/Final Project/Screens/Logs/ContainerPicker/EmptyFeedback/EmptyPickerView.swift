//
//  EmptyPickerView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct EmptyPickerView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 24) {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [DS.Color.accent.opacity(0.12), .clear],
                                center: .center,
                                startRadius: 0,
                                endRadius: 55
                            )
                        )
                        .frame(width: 110, height: 110)

                    Circle()
                        .stroke(DS.Color.accent.opacity(0.1), lineWidth: 1)
                        .frame(width: 90, height: 90)

                    Image(systemName: "terminal")
                        .font(.system(size: 36, weight: .ultraLight))
                        .foregroundColor(DS.Color.accent.opacity(0.45))
                }

                VStack(spacing: 8) {
                    Text("Select a Container")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(DS.Color.textSecondary)

                    Text("Use the picker above to begin\nstreaming live container logs")
                        .font(DS.Font.mono(12))
                        .foregroundColor(DS.Color.textTertiary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }

                HStack(spacing: 0) {
                    Text("$ ")
                        .font(.system(size: 13, design: .monospaced))
                        .foregroundColor(DS.Color.success.opacity(0.5))
                    BlinkingCursor()
                }
            }

            Spacer()
        }
    }
}
