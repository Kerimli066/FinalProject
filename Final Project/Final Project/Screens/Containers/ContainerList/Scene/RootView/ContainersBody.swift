//
//  ContainersBody.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//

import SwiftUI

struct ContainersBody: View {
    let isLoading: Bool
    let containersEmpty: Bool
    let filtered: [ContainerInfo]
    let latestStats: [String: ContainerStats]
    let searchText: String

    let onRefresh: () -> Void
    let onSelectContainer: ((ContainerInfo) -> Void)?

    var body: some View {
        ZStack {
            if isLoading && containersEmpty {
                ContainersSkeletonList()
            } else if filtered.isEmpty {
                ContainersEmptyState(searchText: searchText)
            } else {
                ContainersList(
                    filtered: filtered,
                    latestStats: latestStats,
                    onRefresh: onRefresh,
                    onSelectContainer: onSelectContainer
                )
            }
        }
    }
}
