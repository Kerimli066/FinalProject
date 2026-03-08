//
//  NetworksListView.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct NetworksListView: View {
    @ObservedObject var vm: ContainersTabViewModel

    var body: some View {
        Group {
            if vm.isLoadingNetworks {
                CenteredLoader(message: "Loading networks…")
            } else if vm.networks.isEmpty {
                CenteredEmpty(
                    icon: "network.slash",
                    title: "No Networks",
                    message: "No Docker networks found on this host"
                )
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        SummaryBanner(items: networksSummaryItems)
                            .padding(.horizontal, DS.Space.sm)
                            .padding(.bottom, 10)

                        PremiumCardList(items: vm.networks) { net, idx in
                            PremiumNetworkRow(network: net, index: idx)
                        }
                        .padding(.horizontal, DS.Space.sm)
                        .padding(.bottom, DS.Space.xxl)
                    }
                }
                .refreshable { await vm.refresh() }
            }
        }
    }

    private var networksSummaryItems: [SummaryItem] {
        let connected = vm.networks.reduce(0) { $0 + ($1.Containers?.count ?? 0) }
        let drivers = Set(vm.networks.compactMap { $0.Driver }).count

        return [
            SummaryItem(
                value: "\(vm.networks.count)",
                label: "networks",
                icon: "network",
                color: DS.Color.accent
            ),
            SummaryItem(
                value: "\(drivers)",
                label: "drivers",
                icon: "gearshape.2.fill",
                color: DS.Color.accentSoft
            ),
            SummaryItem(
                value: "\(connected)",
                label: "containers",
                icon: "shippingbox.fill",
                color: DS.Color.success
            )
        ]
    }
}
