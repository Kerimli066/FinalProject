//
//  ContainerMetricRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerMetricRow: View {
    let icon: String
    let label: String
    let color: Color
    let value: String
    let progress: Double
    let sub: String

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(color.opacity(0.1))
                    .frame(width: 30, height: 30)

                Image(systemName: icon)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(color)
            }

            VStack(alignment: .leading, spacing: 1) {
                Text(label)
                    .font(DS.Font.caption(12))
                    .foregroundColor(DS.Color.textSecondary)

                Text(sub)
                    .font(DS.Font.mono(9))
                    .foregroundColor(DS.Color.textMuted)
            }
            .frame(width: 130, alignment: .leading)

            LumenProgressBar(progress: progress, color: color, height: 7)

            Text(value)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(color)
                .frame(width: 54, alignment: .trailing)
                .shadow(color: color.opacity(0.35), radius: 4)
        }
    }
}