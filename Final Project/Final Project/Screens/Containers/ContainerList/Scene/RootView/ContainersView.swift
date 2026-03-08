//
//  ContainersView.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import SwiftUI

struct ContainersView: View {
    @StateObject private var vm = ContainersViewModel()
    var onSelectContainer: ((ContainerInfo) -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            ContainersControlBar(
                searchText: $vm.searchText,
                filterState: $vm.filterState,
                containersIsEmpty: vm.containers.isEmpty,
                runningCount: vm.runningCount,
                stoppedCount: vm.stoppedCount,
                isLoading: vm.isLoading,
                onRefresh: { vm.refresh() }
            )
            .padding(.horizontal, DS.Space.sm)
            .padding(.bottom, 10)

            ContainersBody(
                isLoading: vm.isLoading,
                containersEmpty: vm.containers.isEmpty,
                filtered: vm.filtered,
                latestStats: vm.latestStats,
                searchText: vm.searchText,
                onRefresh: { vm.refresh() },
                onSelectContainer: onSelectContainer
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(DS.Anim.smooth, value: vm.filtered.count)
        }
        .onAppear    { vm.onAppear() }
        .onDisappear { vm.onDisappear() }
    }
}
