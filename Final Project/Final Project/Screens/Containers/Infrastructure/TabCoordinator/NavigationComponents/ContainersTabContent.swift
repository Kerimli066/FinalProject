//
//  ContainersTabContent.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//

import SwiftUI

struct ContainersTabContent: View {
    typealias Segment = ContainersTabViewModel.Segment

    let selected: Segment
    let vm: ContainersTabViewModel
    let onSelectContainer: ((ContainerInfo) -> Void)?

    @ViewBuilder
    var body: some View {
        switch selected {
        case .containers:
            ContainersView(onSelectContainer: onSelectContainer)
                .transition(.opacity)

        case .images:
            ImagesListView(vm: vm)
                .transition(.opacity)

        case .volumes:
            VolumesListView(vm: vm)
                .transition(.opacity)

        case .networks:
            NetworksListView(vm: vm)
                .transition(.opacity)
        }
    }
}
