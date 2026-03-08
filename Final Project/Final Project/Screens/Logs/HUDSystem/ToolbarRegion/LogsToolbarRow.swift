//
//  LogsToolbarRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct LogsToolbarRow: View {
    let filteredCount: Int
    @Binding var autoScroll: Bool
    let isPaused: Bool

    let onPauseResume: () -> Void
    let onClear: () -> Void

    var body: some View {
        HStack(spacing: 8) {

            LineCountPill(count: filteredCount)

            Spacer()

            LogsToolButton(
                icon: autoScroll ? "arrow.down.circle.fill" : "arrow.down.circle",
                label: "Auto",
                color: autoScroll ? DS.Color.success : DS.Color.textTertiary,
                active: autoScroll
            ) { autoScroll.toggle() }

            LogsToolButton(
                icon: isPaused ? "play.fill" : "pause.fill",
                label: isPaused ? "Resume" : "Pause",
                color: isPaused ? DS.Color.success : DS.Color.textSecondary,
                active: isPaused
            ) { onPauseResume() }

            Button { onClear() } label: {
                HStack(spacing: 5) {
                    Image(systemName: "trash")
                        .font(.system(size: 11, weight: .semibold))
                    Text("Clear")
                        .font(.system(size: 11, weight: .semibold))
                }
                .foregroundColor(DS.Color.danger.opacity(0.8))
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(DS.Color.danger.opacity(0.06))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(DS.Color.danger.opacity(0.2), lineWidth: 1)
                        )
                )
            }
            .buttonStyle(.plain)
        }
        .padding(.bottom, 10)
    }
}


