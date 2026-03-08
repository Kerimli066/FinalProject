//
//  ContainersList.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainersList: View {
    let filtered: [ContainerInfo]
    let latestStats: [String: ContainerStats]
    let onRefresh: () -> Void
    let onSelectContainer: ((ContainerInfo) -> Void)?

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(Array(filtered.enumerated()), id: \.element.id) { idx, c in
                    ContainerCard(
                        container: c,
                        stats: latestStats[c.id],
                        index: idx,
                        onTap: { onSelectContainer?(c) }
                    )
                    .padding(.horizontal, DS.Space.sm)
                }
                Color.clear.frame(height: DS.Space.xxl)
            }
            .padding(.top, 2)
        }
        .refreshable {
            await withCheckedContinuation { continuation in
                onRefresh()
                Task {
                    try? await Task.sleep(nanoseconds: 600_000_000)
                    continuation.resume()
                }
            }
        }
    }
}
