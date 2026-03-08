//
//  PremiumCardList.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct PremiumCardList<Item: Identifiable, Row: View>: View {
    let items: [Item]
    let row: (_ item: Item, _ index: Int) -> Row

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { idx, it in
                row(it, idx)

                if idx < items.count - 1 {
                    Rectangle()
                        .fill(DS.Color.cardBorder)
                        .frame(height: 1)
                        .padding(.horizontal, 14)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.lg)
                .fill(DS.Color.bg2)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.lg)
                        .stroke(DS.Color.cardBorder, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 8)
        )
    }
}