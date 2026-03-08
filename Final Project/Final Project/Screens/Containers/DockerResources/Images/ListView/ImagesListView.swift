//
//  ImagesListView.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ImagesListView: View {
    @ObservedObject var vm: ContainersTabViewModel

    private var totalSize: Int64 { vm.images.compactMap { $0.Size }.reduce(0, +) }
    private var maxSize: Int64 { vm.images.compactMap { $0.Size }.max() ?? 1 }

    var body: some View {
        Group {
            if vm.isLoadingImages {
                CenteredLoader(message: "Loading images…")
            } else if vm.images.isEmpty {
                CenteredEmpty(
                    icon: "square.stack.3d.up",
                    title: "No Images",
                    message: "No Docker images found on this host"
                )
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        SummaryBanner(items: imagesSummaryItems)
                            .padding(.horizontal, DS.Space.sm)
                            .padding(.bottom, 10)

                        PremiumCardList(items: vm.images) { img, idx in
                            PremiumImageRow(image: img, index: idx, maxSize: maxSize)
                        }
                        .padding(.horizontal, DS.Space.sm)
                        .padding(.bottom, DS.Space.xxl)
                    }
                }
                .refreshable { await vm.refresh() }
            }
        }
    }

    private var imagesSummaryItems: [SummaryItem] {
        let inUse = vm.images.filter { ($0.Containers ?? 0) > 0 }.count
        return [
            SummaryItem(
                value: "\(vm.images.count)",
                label: "images",
                icon: "square.stack.3d.up.fill",
                color: DS.Color.accentSoft
            ),
            SummaryItem(
                value: formatBytes(totalSize),
                label: "total size",
                icon: "internaldrive.fill",
                color: DS.Color.warning
            ),
            SummaryItem(
                value: "\(inUse)",
                label: "in use",
                icon: "checkmark.circle.fill",
                color: DS.Color.success
            )
        ]
    }

    private func formatBytes(_ b: Int64) -> String {
        if b > 1_000_000_000 { return String(format: "%.1f GB", Double(b) / 1_000_000_000) }
        return String(format: "%.0f MB", Double(b) / 1_000_000)
    }
}
