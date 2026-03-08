//
//  ContainersTabView.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//


import SwiftUI

struct ContainersTabView: View {
    @StateObject private var vm = ContainersTabViewModel()
    var onSelectContainer: ((ContainerInfo) -> Void)? = nil
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            ContainersTabHeader(
                selectedSegmentTitle: vm.selectedSegment.title,
                appeared: appeared
            )
            .padding(.horizontal, DS.Space.sm)
            .padding(.top, 16)
            .padding(.bottom, 12)

            ContainersTabSegmentBar(
                selected: vm.selectedSegment,
                onSelect: { seg in
                    withAnimation(DS.Anim.spring) { vm.selectedSegment = seg }
                    vm.loadIfNeeded(seg)
                },
                appeared: appeared
            )
            .padding(.horizontal, DS.Space.sm)
            .padding(.bottom, 10)

            ContainersTabContent(
                selected: vm.selectedSegment,
                vm: vm,
                onSelectContainer: onSelectContainer
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ContainersTabBackground())
        .onAppear {
            vm.onAppear()
            withAnimation(DS.Anim.smooth) { appeared = true }
        }
    }
}
