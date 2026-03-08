//
//  ContainersFilterChip.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainersFilterChip: View {
    let filter: ContainersViewModel.FilterState
    let selected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 4) {
                Image(systemName: filter.icon)
                    .font(.system(size: 9, weight: .bold))
                Text(filter.rawValue)
                    .font(DS.Font.label(11))
            }
            .foregroundColor(selected ? DS.Color.textPrimary : DS.Color.textTertiary)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(selected ? DS.Color.accent : DS.Color.bg4)
                    .overlay(
                        Capsule()
                            .stroke(selected ? DS.Color.accent.opacity(0.6) : DS.Color.cardBorder, lineWidth: 1)
                    )
                    .shadow(color: selected ? DS.Color.accent.opacity(0.4) : .clear, radius: 8)
            )
        }
        .buttonStyle(.plain)
    }
}
