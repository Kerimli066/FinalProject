//
//  DashboardView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var vm = DashboardViewModel()
    var onViewAllAlerts: (() -> Void)? = nil
    @State private var appeared = false

    var body: some View {
        ZStack {
            DS.Color.bg0.ignoresSafeArea()
            DashAmbientBackgroundView(healthColor: vm.healthStatus.color, healthLabel: vm.healthStatus.label)
                .ignoresSafeArea()

            if vm.isLoading && vm.containers.isEmpty {
                DashLoadingView(appeared: appeared)
            } else {
                DashMainContentView(
                    vm: vm,
                    appeared: appeared,
                    onViewAllAlerts: onViewAllAlerts
                )
            }
        }
        .onAppear {
            vm.onAppear()
            withAnimation(.spring(response: 0.8, dampingFraction: 0.75)) {
                appeared = true
            }
        }
        .onDisappear { vm.onDisappear() }
    }
}
