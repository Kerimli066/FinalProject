//
//  AlertsSearchBar.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct AlertsSearchBar: View {
    @Binding var searchText: String
    let appeared: Bool

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14))
                .foregroundColor(DS.Color.textTertiary)

            TextField("Search container or message...", text: $searchText)
                .font(DS.Font.body(14))
                .foregroundColor(DS.Color.textPrimary)
                .tint(DS.Color.danger)

            if !searchText.isEmpty {
                Button { searchText = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 15))
                        .foregroundColor(DS.Color.textTertiary)
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(.horizontal, 16).padding(.vertical, 13)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.md)
                .fill(DS.Color.bg2)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.md)
                        .stroke(searchText.isEmpty ? DS.Color.cardBorder : DS.Color.danger.opacity(0.3),
                                lineWidth: 1)
                )
        )
        .animation(DS.Anim.fast, value: searchText.isEmpty)
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.35).delay(0.28), value: appeared)
    }
}