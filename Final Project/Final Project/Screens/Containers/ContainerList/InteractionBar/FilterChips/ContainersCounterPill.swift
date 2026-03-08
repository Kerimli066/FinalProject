//
//  ContainersCounterPill.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainersCounterPill: View {
    let count: Int
    let color: Color
    let icon: String

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: icon)
                .font(.system(size: 6, weight: .black))
                .foregroundColor(color)

            Text("\(count)")
                .font(DS.Font.monoSemibold(11))
                .foregroundColor(color)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(color.opacity(0.07))
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(color.opacity(0.18), lineWidth: 1)
                )
        )
    }
}
