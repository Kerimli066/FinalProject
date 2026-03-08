//
//  ContainersSearchField.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainersSearchField: View {
    @Binding var searchText: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(searchText.isEmpty ? DS.Color.textTertiary : DS.Color.accent)

            TextField("Search containers…", text: $searchText)
                .font(DS.Font.mono(13))
                .foregroundColor(DS.Color.textPrimary)
                .tint(DS.Color.accent)

            if !searchText.isEmpty {
                Button { searchText = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(DS.Color.textTertiary)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.sm)
                .fill(DS.Color.bg3)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.sm)
                        .stroke(searchText.isEmpty ? DS.Color.cardBorder : DS.Color.accent.opacity(0.45), lineWidth: 1)
                )
        )
        .animation(DS.Anim.fast, value: searchText.isEmpty)
    }
}
