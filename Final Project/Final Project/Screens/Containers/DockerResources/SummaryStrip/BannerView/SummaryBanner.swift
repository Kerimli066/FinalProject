//
//  SummaryBanner.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct SummaryBanner: View {
    let items: [SummaryItem]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { idx, it in
                SummaryChip(item: it)

                if idx < items.count - 1 {
                    Rectangle()
                        .fill(DS.Color.cardBorder)
                        .frame(width: 1, height: 28)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.sm)
                .fill(DS.Color.bg3)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.sm)
                        .stroke(DS.Color.cardBorder, lineWidth: 1)
                )
        )
    }
}

