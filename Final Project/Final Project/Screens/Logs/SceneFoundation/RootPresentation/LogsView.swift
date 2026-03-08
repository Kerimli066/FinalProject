//
//  LogsView.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import SwiftUI

struct LogsView: View {
    @StateObject private var vm: LogsViewModel
    @ObservedObject var state: LogsState
    @State private var appeared = false

    init(state: LogsState = LogsState()) {
        self.state = state
        _vm = StateObject(wrappedValue: LogsViewModel())
    }

    var body: some View {
        ZStack {
            DS.Color.bg0.ignoresSafeArea()

            VStack(spacing: 0) {
                LogsHUDHeader(
                    selectedContainer: vm.selectedContainer,
                    isStreaming: vm.isStreaming,
                    isPaused: vm.isPaused,
                    containers: vm.containers,
                    onSelect: { vm.select($0) }
                )
                .padding(.horizontal, DS.Space.sm)
                .padding(.top, 16)
                .padding(.bottom, 14)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : -8)

                if let error = vm.loadError ?? vm.streamError {
                    LogsErrorBanner(message: error)
                        .padding(.horizontal, DS.Space.sm)
                        .padding(.bottom, 10)
                }

                if vm.selectedContainer != nil {
                    LogLevelFilterRow(
                        selectedLevel: $vm.selectedLevel,
                        countForLevel: { vm.countForLevel($0) }
                    )
                    .padding(.horizontal, DS.Space.sm)
                    .padding(.bottom, 10)
                    .opacity(appeared ? 1 : 0)

                    LogsToolbarRow(
                        filteredCount: vm.filteredLogs.count,
                        autoScroll: $vm.autoScroll,
                        isPaused: vm.isPaused,
                        onPauseResume: { vm.isPaused ? vm.resume() : vm.pause() },
                        onClear: { vm.clearLogs() }
                    )
                    .padding(.horizontal, DS.Space.sm)
                    .padding(.bottom, 0)
                    .opacity(appeared ? 1 : 0)

                    TerminalSeparator(title: "OUTPUT")

                    TerminalOutputView(
                        lines: vm.filteredLogs,
                        autoScroll: vm.autoScroll,
                        isPaused: vm.isPaused
                    )
                } else {
                    EmptyPickerView()
                }
            }
        }
        .onAppear {
            vm.onAppear(preselect: state.preselected, externalContainers: state.containers)
            withAnimation(DS.Anim.smooth.delay(0.06)) {
                appeared = true
            }
        }
        .onDisappear {
            vm.onDisappear()
        }
        .onChange(of: state.preselected?.id) { _, _ in
            vm.updateContainers(state.containers, preselect: state.preselected)
        }
        .onChange(of: state.containers.count) { _, _ in
            vm.updateContainers(state.containers, preselect: state.preselected)
        }
    }
}
