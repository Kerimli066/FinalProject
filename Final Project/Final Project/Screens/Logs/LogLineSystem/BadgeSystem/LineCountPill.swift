//
//  LineCountPill.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct LineCountPill: View {
    let count: Int

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "line.3.horizontal")
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(DS.Color.textMuted)

            Text("\(count)")
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .foregroundColor(DS.Color.textSecondary)

            Text("lines")
                .font(.system(size: 10, weight: .medium, design: .monospaced))
                .foregroundColor(DS.Color.textTertiary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(DS.Color.bg3)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(DS.Color.cardBorder, lineWidth: 1)
                )
        )
    }
}
