//
//  SummaryChip.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//

import SwiftUI

struct SummaryChip: View {
    let item: SummaryItem

    var body: some View {
        HStack(spacing: 7) {
            Image(systemName: item.icon)
                .font(.system(size: 11))
                .foregroundColor(item.color)

            VStack(alignment: .leading, spacing: 1) {
                Text(item.value)
                    .font(DS.Font.monoSemibold(13))
                    .foregroundColor(DS.Color.textPrimary)

                Text(item.label)
                    .font(DS.Font.label(9))
                    .foregroundColor(DS.Color.textMuted)
                    .tracking(0.5)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 11)
    }
}
