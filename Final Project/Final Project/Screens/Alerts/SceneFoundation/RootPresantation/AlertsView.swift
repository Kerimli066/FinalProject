//
//  AlertView.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.03.26.
//

import SwiftUI

struct AlertView: View {
    @StateObject private var vm = AlertViewModel()
    @State private var appeared = false

    var body: some View {
        ZStack {
            DS.Color.bg0.ignoresSafeArea()
            AmbientBackgroundView().ignoresSafeArea()

            VStack(spacing: 0) {
                AlertsHeaderView(vm: vm, appeared: appeared)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 16)

                if let error = vm.errorMessage, !error.isEmpty {
                    AlertsErrorBanner(message: error)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                }

                AlertsSearchBar(searchText: $vm.searchText, appeared: appeared)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)

                AlertsFilterRow(vm: vm, appeared: appeared)
                    .padding(.bottom, 14)

                if vm.isLoading && vm.alerts.isEmpty {
                    AlertsLoadingView(appeared: appeared)
                } else if vm.filteredAlerts.isEmpty {
                    AlertsEmptyStateView(searchText: vm.searchText)
                } else {
                    AlertsListView(
                        alerts: vm.filteredAlerts,
                        appeared: appeared,
                        onRefresh: { await vm.load(showLoading: false) }
                    )
                }
            }
        }
        .onAppear {
            vm.onAppear()
            withAnimation(.spring(response: 0.8, dampingFraction: 0.75)) {
                appeared = true
            }
        }
        .onDisappear {
            vm.onDisappear()
        }
        .alert("Clear all alerts?", isPresented: $vm.showClearConfirm) {
            Button("Clear All", role: .destructive) {
                Task { await vm.clearAll() }
            }
            Button("Cancel", role: .cancel) {}
        }
        .contentShape(Rectangle())
        .onTapGesture { UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) }
    }
}
