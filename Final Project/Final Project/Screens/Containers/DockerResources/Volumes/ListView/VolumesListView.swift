//
//  VolumesListView.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct VolumesListView: View {
    @ObservedObject var vm: ContainersTabViewModel

    var body: some View {
        Group {
            if vm.isLoadingVolumes {
                CenteredLoader(message: "Loading volumes…")
            } else if vm.volumes.isEmpty {
                CenteredEmpty(
                    icon: "externaldrive.badge.xmark",
                    title: "No Volumes",
                    message: "No Docker volumes found on this host"
                )
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        SummaryBanner(items: volumesSummaryItems)
                            .padding(.horizontal, DS.Space.sm)
                            .padding(.bottom, 10)

                        PremiumCardList(items: vm.volumes) { vol, idx in
                            PremiumVolumeRow(volume: vol, index: idx)
                        }
                        .padding(.horizontal, DS.Space.sm)
                        .padding(.bottom, DS.Space.xxl)
                    }
                }
                .refreshable { await vm.refresh() }
            }
        }
    }

    private var volumesSummaryItems: [SummaryItem] {
        let drivers = Set(vm.volumes.map { $0.Driver }).count
        let named = vm.volumes.filter { !$0.Name.hasPrefix("sha256") && !$0.Name.contains("_") }.count

        return [
            SummaryItem(
                value: "\(vm.volumes.count)",
                label: "volumes",
                icon: "externaldrive.fill",
                color: DS.Color.warning
            ),
            SummaryItem(
                value: "\(drivers)",
                label: "drivers",
                icon: "gearshape.fill",
                color: DS.Color.accentSoft
            ),
            SummaryItem(
                value: "\(named)",
                label: "named",
                icon: "tag.fill",
                color: DS.Color.success
            )
        ]
    }
}
