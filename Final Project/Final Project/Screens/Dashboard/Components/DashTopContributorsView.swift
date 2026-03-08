//
//  DashTopContributorsView.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

struct DashTopContributorsView: View {
    @ObservedObject var vm: DashboardViewModel
    let appeared: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeader(title: "Top Contributors", icon: "chart.bar.fill")

            HStack(spacing: 10) {
                TopContributorItem(
                    icon: "chart.line.uptrend.xyaxis",
                    label: "HIGHEST CPU",
                    name: vm.topCPUContainer?.name ?? "—",
                    valueStr: vm.topCPUContainer.map { String(format: "%.1f%%", $0.value) } ?? "—",
                    barValue: vm.topCPUContainer.map { min($0.value / 100.0, 1.0) } ?? 0,
                    color: DS.Color.accent
                )

                TopContributorItem(
                    icon: "memorychip",
                    label: "HIGHEST MEM",
                    name: vm.topMemoryContainer?.name ?? "—",
                    valueStr: vm.topMemoryContainer.map { String(format: "%.0f MB", $0.valueMB) } ?? "—",
                    barValue: vm.topMemoryContainer.map { min($0.valueMB / 2048.0, 1.0) } ?? 0,
                    color: DS.Color.accentSoft
                )
            }
        }
        .padding(DS.Space.md)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.lg)
                .fill(DS.Color.bg2)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.lg)
                        .stroke(
                            LinearGradient(
                                colors: [DS.Color.accent.opacity(0.12), DS.Color.cardBorder],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .shadow(color: DS.Color.accent.opacity(0.05), radius: 18, x: 0, y: 6)
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 1)
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 10)
        .animation(.spring(response: 0.55, dampingFraction: 0.8).delay(0.42), value: appeared)
    }
}
