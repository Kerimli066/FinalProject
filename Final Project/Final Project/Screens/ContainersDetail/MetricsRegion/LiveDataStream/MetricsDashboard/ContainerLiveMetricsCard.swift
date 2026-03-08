//
//  ContainerLiveMetricsCard.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//

import SwiftUI

struct ContainerLiveMetricsCard: View {
    @ObservedObject var statsVM: StatsStreamViewModel

    private let cpuThr = AlertSeverityHelper.Threshold.cpuHigh
    private let memThr = AlertSeverityHelper.Threshold.memHigh

    private var cpuClr: Color {
        ContainerDetailThreshold.thresholdColor(statsVM.cpuPercent, thr: cpuThr)
    }

    private var memClr: Color {
        ContainerDetailThreshold.thresholdColor(statsVM.memPercent, thr: memThr)
    }

    private var wsStatusText: String { ContainerWSStatus.text(for: statsVM) }
    private var wsStatusColor: Color { ContainerWSStatus.color(for: statsVM) }
    private var isConnected: Bool { ContainerWSStatus.isConnected(statsVM) }

    var body: some View {
        VStack(spacing: 0) {
            header
            DividerLine()
            metrics
            DividerLine()
            footer
        }
        .background(ContainerDetailCard(glow: DS.Color.accent))
    }

    private var header: some View {
        HStack {
            HStack(spacing: 6) {
                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(DS.Color.accent)

                Text("LIVE METRICS")
                    .font(DS.Font.label(11))
                    .foregroundColor(DS.Color.textSecondary)
                    .tracking(1.0)
            }

            Spacer()

            StatusPill(label: wsStatusText, color: wsStatusColor, pulsing: isConnected)
        }
        .padding(DS.Space.sm)
    }

    private var metrics: some View {
        VStack(spacing: 12) {
            ContainerMetricRow(
                icon: "cpu",
                label: "CPU Usage",
                color: cpuClr,
                value: String(format: "%.1f%%", statsVM.cpuPercent),
                progress: statsVM.cpuPercent / 100,
                sub: "threshold \(Int(cpuThr))%"
            )

            ContainerMetricRow(
                icon: "memorychip",
                label: "Memory",
                color: memClr,
                value: String(format: "%.1f%%", statsVM.memPercent),
                progress: statsVM.memPercent / 100,
                sub: statsVM.memLimitMB > 0
                    ? String(format: "%.0f / %.0f MB · thr %d%%",
                             statsVM.memUsedMB, statsVM.memLimitMB, Int(memThr))
                    : "threshold \(Int(memThr))%"
            )
        }
        .padding(DS.Space.sm)
    }

    private var footer: some View {
        HStack(spacing: 5) {
            Image(systemName: "bolt.fill")
                .font(.system(size: 8))
                .foregroundColor(DS.Color.textMuted)

            Text(statsVM.isOfflineFallback ? "Cached metrics" : "WebSocket stream")
                .font(DS.Font.mono(10))
                .foregroundColor(DS.Color.textMuted)
        }
        .padding(.horizontal, DS.Space.sm)
        .padding(.vertical, 8)
    }
}
