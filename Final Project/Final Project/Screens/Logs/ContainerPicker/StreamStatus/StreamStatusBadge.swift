//
//  StreamStatusBadge.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct StreamStatusBadge: View {
    let isStreaming: Bool
    let isPaused: Bool

    var body: some View {
        HStack(spacing: 6) {
            if isStreaming {
                PulseDot(color: DS.Color.success, size: 6)
                Text("STREAMING")
                    .font(.system(size: 9, weight: .black, design: .monospaced))
                    .foregroundColor(DS.Color.success)
                    .tracking(1)
            } else if isPaused {
                Image(systemName: "pause.fill")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(DS.Color.warning)

                Text("PAUSED")
                    .font(.system(size: 9, weight: .black, design: .monospaced))
                    .foregroundColor(DS.Color.warning)
                    .tracking(1)
            } else {
                Circle().fill(DS.Color.textMuted).frame(width: 6, height: 6)
                Text("IDLE")
                    .font(.system(size: 9, weight: .black, design: .monospaced))
                    .foregroundColor(DS.Color.textTertiary)
                    .tracking(1)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(
            Capsule()
                .fill(isStreaming
                      ? DS.Color.success.opacity(0.08)
                      : isPaused
                        ? DS.Color.warning.opacity(0.08)
                        : DS.Color.bg3)
                .overlay(
                    Capsule().stroke(
                        isStreaming
                        ? DS.Color.success.opacity(0.25)
                        : isPaused
                          ? DS.Color.warning.opacity(0.25)
                          : DS.Color.cardBorder,
                        lineWidth: 1
                    )
                )
        )
    }
}
