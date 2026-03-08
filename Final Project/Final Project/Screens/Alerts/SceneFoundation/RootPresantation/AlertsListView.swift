//
//  AlertsListView.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct AlertsListView: View {
    let alerts: [Alert]
    let appeared: Bool
    let onRefresh: () async -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 10) {
                ForEach(Array(alerts.enumerated()), id: \.element.id) { i, alert in
                    ProAlertRow(alert: alert, index: i, appeared: appeared)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .animation(DS.Anim.spring, value: alerts.map(\.id))
        }
        .refreshable { await onRefresh() }
    }
}