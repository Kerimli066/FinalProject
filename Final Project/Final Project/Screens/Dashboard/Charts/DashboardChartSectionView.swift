//
//  DashboardChartSectionView.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//



import SwiftUI

struct DashboardChartSectionView: View {
    @Binding var selectedChartTab: DashboardViewModel.ChartTab

    let cpuContributionSeries: [(name: String, color: Color, points: [DashChartPoint])]

    let globalCPUPoints: [DashChartPoint]
    let globalMemoryPoints: [DashChartPoint]

    var body: some View {
        VStack(spacing: 10) {
            DashChartTabSelector(selected: $selectedChartTab)

            Group {
                switch selectedChartTab {
                case .cpuContribution:
                    DashMultiLineChart(
                        series: cpuContributionSeries,
                        title: "CPU by Container",
                        subtitle: "Per-container CPU% over time"
                    )

                case .cpuTrend:
                    DashTrendChart(
                        points: globalCPUPoints,
                        color: DS.Color.accent,
                        title: "Global CPU Trend",
                        subtitle: "Total CPU% across all containers"
                    )

                case .memoryTrend:
                    DashTrendChart(
                        points: globalMemoryPoints,
                        color: DS.Color.accentSoft,
                        title: "Global Memory Trend",
                        subtitle: "Total memory (MB) across all containers"
                    )
                }
            }
            .transition(.opacity.combined(with: .scale(scale: 0.98)))
            .animation(DS.Anim.spring, value: selectedChartTab)
        }
    }
}
