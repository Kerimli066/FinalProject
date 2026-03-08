//
//  TopContributorItem.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//



import SwiftUI

struct TopContributorItem: View {
    let icon:     String
    let label:    String
    let name:     String
    let valueStr: String
    let barValue: Double
    let color:    Color

    var body: some View {
        VStack(alignment: .leading, spacing: DS.Space.xs) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(color)
                Text(label)
                    .font(DS.Font.label(9))
                    .foregroundColor(DS.Color.textTertiary)
                    .tracking(1.0)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(DS.Font.headline(13))
                    .foregroundColor(DS.Color.textPrimary)
                    .lineLimit(1)
                Text(valueStr)
                    .font(DS.Font.display(20))
                    .foregroundColor(color)
                    .shadow(color: color.opacity(0.4), radius: 6)
                DashProgressBar(value: barValue, color: color)
            }
            .padding(DS.Space.sm)
            .background(
                RoundedRectangle(cornerRadius: DS.Radius.sm)
                    .fill(color.opacity(0.06))
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.Radius.sm)
                            .stroke(color.opacity(0.18), lineWidth: 1)
                    )
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
