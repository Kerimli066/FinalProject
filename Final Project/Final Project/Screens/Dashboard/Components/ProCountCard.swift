//
//  ProCountCard.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//



import SwiftUI

struct ProCountCard: View {
    let icon:  String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: DS.Radius.xs)
                    .fill(color.opacity(0.12))
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.Radius.xs)
                            .stroke(color.opacity(0.2), lineWidth: 1)
                    )
                    .frame(width: 34, height: 34)
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(color)
            }
            Spacer()
            Text(value)
                .font(DS.Font.display(32))
                .foregroundColor(DS.Color.textPrimary)
                .shadow(color: color.opacity(0.35), radius: 8)
            Text(label)
                .font(DS.Font.label(9))
                .foregroundColor(color.opacity(0.7))
                .tracking(1.5)
                .padding(.top, 3)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 112)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.lg)
                .fill(DS.Color.bg2)
                .overlay(
                    VStack {
                        LinearGradient(
                            colors: [color.opacity(0.12), .clear],
                            startPoint: .top, endPoint: .bottom
                        )
                        .frame(height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.lg))
                        Spacer()
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.lg)
                        .stroke(color.opacity(0.18), lineWidth: 1)
                )
        )
        .shadow(color: color.opacity(0.08), radius: 14, x: 0, y: 5)
    }
}
