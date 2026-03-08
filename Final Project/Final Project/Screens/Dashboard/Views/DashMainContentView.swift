//
//  DashMainContentView.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

struct DashMainContentView: View {
    @ObservedObject var vm: DashboardViewModel
    let appeared: Bool
    let onViewAllAlerts: (() -> Void)?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                DashHeaderRowView(vm: vm, appeared: appeared)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 20)

                DashHealthCardView(vm: vm, appeared: appeared)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 14)

                DashStatsGridView(vm: vm, appeared: appeared)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 14)

                
                DashboardChartSectionView(
                    selectedChartTab: $vm.selectedChartTab,
                    cpuContributionSeries: vm.cpuContributionSeries,
                    globalCPUPoints: vm.globalCPUPoints,
                    globalMemoryPoints: vm.globalMemoryPoints
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 14)

                DashTopContributorsView(vm: vm, appeared: appeared)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 14)

                if !vm.recentAlerts.isEmpty {
                    DashAlertsSectionView(vm: vm, appeared: appeared, onViewAllAlerts: onViewAllAlerts)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 14)
                }

                Spacer(minLength: 48)
            }
        }
        .refreshable { vm.refresh() }
    }
}
