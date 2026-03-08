//
//  ContainerDetailView.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import SwiftUI
import FirebaseAuth

struct ContainerDetailView: View {
    @StateObject private var vm: ContainerDetailViewModel
    @StateObject private var statsVM = StatsStreamViewModel()

    @State private var headerAppeared = false
    @State private var metricsAppeared = false
    @State private var actionsAppeared = false
    @State private var sectionsAppeared = false

    init(
        container: ContainerInfo,
        onRemoved: (() -> Void)? = nil,
        onActionCompleted: (() -> Void)? = nil,
        onViewLogs: ((ContainerInfo) -> Void)? = nil
    ) {
        let v = ContainerDetailViewModel(container: container)
        v.onRemoved = onRemoved
        v.onActionCompleted = onActionCompleted
        v.onViewLogs = onViewLogs
        _vm = StateObject(wrappedValue: v)
    }

    private var isSystemCritical: Bool { vm.container.isSystemCritical }

    private var ambientColor: Color {
        if isSystemCritical { return DS.Color.accent }
        return vm.container.isRunning ? DS.Color.success : DS.Color.textTertiary
    }

    var body: some View {
        ZStack {
            DS.Color.bg0.ignoresSafeArea()
            ContainerDetailAmbientBackground(accent: ambientColor)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    if isSystemCritical {
                        ContainerCriticalBanner()
                            .opacity(headerAppeared ? 1 : 0)
                            .offset(y: headerAppeared ? 0 : -8)
                    }

                    ContainerHeaderCard(
                        container: vm.container,
                        isSystemCritical: isSystemCritical
                    )
                    .opacity(headerAppeared ? 1 : 0)
                    .offset(y: headerAppeared ? 0 : 12)

                    if vm.container.isRunning {
                        ContainerLiveMetricsCard(statsVM: statsVM)
                            .opacity(metricsAppeared ? 1 : 0)
                            .offset(y: metricsAppeared ? 0 : 10)
                    }

                    ContainerActionsCard(
                        vm: vm,
                        isSystemCritical: isSystemCritical
                    )
                    .opacity(actionsAppeared ? 1 : 0)
                    .offset(y: actionsAppeared ? 0 : 10)

                    ContainerViewLogsButton(
                        isEnabled: vm.container.isRunning,
                        onTap: { vm.onViewLogs?(vm.container) }
                    )
                    .opacity(actionsAppeared ? 1 : 0)

                    if vm.isLoadingDetail {
                        ContainerSkeletonAccordions()
                    } else {
                        ContainerDetailSections(
                            envVars: vm.envVars,
                            ports: vm.ports,
                            mounts: vm.mounts,
                            envExpanded: $vm.envExpanded,
                            portsExpanded: $vm.portsExpanded,
                            mountsExpanded: $vm.mountsExpanded
                        )
                        .opacity(sectionsAppeared ? 1 : 0)
                        .offset(y: sectionsAppeared ? 0 : 8)
                    }

                    Spacer(minLength: 48)
                }
                .padding(.horizontal, DS.Space.sm)
                .padding(.top, 12)
            }
        }
        .onAppear {
            vm.onAppear()
            restartStatsIfNeeded()

            withAnimation(DS.Anim.smooth) { headerAppeared = true }
            withAnimation(DS.Anim.smooth.delay(0.10)) { metricsAppeared = true }
            withAnimation(DS.Anim.smooth.delay(0.18)) { actionsAppeared = true }
            withAnimation(DS.Anim.smooth.delay(0.26)) { sectionsAppeared = true }
        }
        .onDisappear {
            vm.onDisappear()
            statsVM.stop()
        }
        .onChange(of: vm.container.isRunning) { _, _ in
            restartStatsIfNeeded()
        }
        .alert("Action Failed", isPresented: $vm.showActionError) {
            Button("OK") {
                vm.showActionError = false
                vm.actionErrorMessage = nil
            }
        } message: {
            Text(vm.actionErrorMessage ?? "An unknown error occurred")
        }
        .confirmationDialog(
            "Remove Container?",
            isPresented: $vm.showRemoveConfirm,
            titleVisibility: .visible
        ) {
            Button("Remove \(vm.container.name)", role: .destructive) {
                Task { await vm.removeContainer() }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action is permanent. All container data will be lost.")
        }
    }

    private func restartStatsIfNeeded() {
        statsVM.stop()
        guard vm.container.isRunning else { return }
        
        Task {
            try? await Task.sleep(nanoseconds: 350_000_000)
            let email = Auth.auth().currentUser?.email
            statsVM.start(containerId: vm.container.id, email: email)
        }
    }
}
