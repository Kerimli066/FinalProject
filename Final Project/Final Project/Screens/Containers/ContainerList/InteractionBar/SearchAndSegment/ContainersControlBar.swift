//
//  ContainersControlBar.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainersControlBar: View {
    @Binding var searchText: String
    @Binding var filterState: ContainersViewModel.FilterState

    let containersIsEmpty: Bool
    let runningCount: Int
    let stoppedCount: Int
    let isLoading: Bool

    let onRefresh: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            ContainersSearchField(searchText: $searchText)

            HStack(spacing: 6) {
                ForEach(ContainersViewModel.FilterState.allCases, id: \.self) { f in
                    ContainersFilterChip(
                        filter: f,
                        selected: filterState == f,
                        onTap: { withAnimation(DS.Anim.spring) { filterState = f } }
                    )
                }

                Spacer()

                if !containersIsEmpty {
                    ContainersCounterPill(count: runningCount, color: DS.Color.success, icon: "circle.fill")
                    ContainersCounterPill(count: stoppedCount, color: DS.Color.textTertiary, icon: "circle")
                }

                ContainersRefreshButton(isLoading: isLoading, onTap: onRefresh)
            }
        }
    }
}
