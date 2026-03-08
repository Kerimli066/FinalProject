//
//  LegendItem.swift
//  Final Project
//
//  Created by SabinaKarimli on 06.03.26.
//

import SwiftUI

struct LegendItem: View {
    let name: String
    let color: Color
    let lastValue: Double?

    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 2)
                .fill(color)
                .frame(width: 20, height: 3)
                .shadow(color: color.opacity(0.5), radius: 3)

            Text(name)
                .font(.system(size: 13, weight: .medium, design: .monospaced))
                .foregroundColor(DS.Color.textSecondary)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let v = lastValue {
                Text(String(format: "%.1f%%", v))
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundColor(color)
                    .fixedSize()
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(color.opacity(0.07))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(color.opacity(0.18), lineWidth: 1)
                )
        )
    }
}
