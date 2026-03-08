//
//  ContainersEmptyState.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainersEmptyState: View {
    let searchText: String

    private var title: String {
        searchText.isEmpty ? "No Containers" : "No Results"
    }

    private var message: String {
        searchText.isEmpty
            ? "No Docker containers found on this host"
            : "Nothing matched \"\(searchText)\""
    }

    var body: some View {
        VStack {
            Spacer()
            EmptyStateView(
                icon: "square.stack.3d.up.slash",
                title: title,
                message: message
            )
            Spacer()
        }
    }
}
