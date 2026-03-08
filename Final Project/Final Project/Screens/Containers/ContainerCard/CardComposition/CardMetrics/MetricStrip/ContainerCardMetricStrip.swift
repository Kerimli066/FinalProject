//
//  ContainerCardMetricStrip.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainerCardMetricStrip: View {
    let stats: ContainerStats?
    let cpuPct: Double
    let memPct: Double
    let cpuColor: Color
    let memColor: Color

    var body: some View {
        Group {
            if let s = stats {
                HStack(spacing: 0) {
                    ContainerCardMetricCell(
                        icon: "cpu",
                        label: "CPU",
                        value: String(format: "%.1f%%", cpuPct),
                        progress: cpuPct / 100,
                        color: cpuColor
                    )

                    Rectangle().fill(DS.Color.cardBorder).frame(width: 1, height: 36)

                    ContainerCardMetricCell(
                        icon: "memorychip",
                        label: "MEM",
                        value: String(format: "%.1f%%", memPct),
                        progress: memPct / 100,
                        color: memColor
                    )

                    Rectangle().fill(DS.Color.cardBorder).frame(width: 1, height: 36)

                    ContainerCardNetworkCell(stats: s)
                }
                .padding(.vertical, 2)
            } else {
                HStack(spacing: 8) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: DS.Color.textMuted))
                        .scaleEffect(0.6)

                    Text("Connecting to metrics…")
                        .font(DS.Font.mono(11))
                        .foregroundColor(DS.Color.textMuted)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
            }
        }
    }
}
