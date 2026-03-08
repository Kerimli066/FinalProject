//
//  DashChartTabSelector.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct DashChartTabSelector: View {
    @Binding var selected: DashboardViewModel.ChartTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(DashboardViewModel.ChartTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(DS.Anim.spring) { selected = tab }
                } label: {
                    Text(tab.rawValue)
                        .font(DS.Font.caption(11))
                        .foregroundColor(selected == tab ? DS.Color.textPrimary : DS.Color.textSecondary)
                        .padding(.horizontal, DS.Space.sm)
                        .padding(.vertical, 8)
                        .background(
                            Group {
                                if selected == tab {
                                    Capsule()
                                        .fill(DS.Color.accent.opacity(0.2))
                                        .overlay(
                                            Capsule().stroke(DS.Color.accent.opacity(0.45), lineWidth: 1)
                                        )
                                        .shadow(color: DS.Color.accent.opacity(0.3), radius: 8)
                                }
                            }
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            Capsule()
                .fill(DS.Color.bg4)
                .overlay(Capsule().stroke(DS.Color.cardBorder, lineWidth: 1))
        )
    }
}
