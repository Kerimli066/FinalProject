//
//  DashStatsGridView.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

struct DashStatsGridView: View {
    @ObservedObject var vm: DashboardViewModel
    let appeared: Bool

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                ProStatCard(
                    icon: "cpu",
                    value: String(format: "%.1f%%", vm.totalCPU),
                    label: "TOTAL CPU",
                    color: DS.Color.accent,
                    sparkline: vm.cpuSparkline
                )
                ProStatCard(
                    icon: "memorychip",
                    value: String(format: "%.0f MB", vm.totalMemoryMB),
                    label: "TOTAL MEM",
                    color: DS.Color.accentSoft,
                    sparkline: vm.memSparkline
                )
            }

            HStack(spacing: 10) {
                ProCountCard(
                    icon: "server.rack",
                    value: "\(vm.runningCount)",
                    label: "RUNNING",
                    color: DS.Color.success
                )
                ProCountCard(
                    icon: "exclamationmark.triangle.fill",
                    value: "\(vm.criticalCount)",
                    label: "CRITICAL",
                    color: vm.criticalCount > 0 ? DS.Color.danger : DS.Color.textTertiary
                )
            }
        }
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 10)
        .animation(.spring(response: 0.55, dampingFraction: 0.8).delay(0.32), value: appeared)
    }
}
