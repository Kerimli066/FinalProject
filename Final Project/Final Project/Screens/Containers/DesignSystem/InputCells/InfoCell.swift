//
//  InfoCell.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct InfoCell: View {
    let icon:  String
    let color: Color
    let text:  String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(color)
                .frame(width: 18)
            Text(text)
                .font(DS.Font.mono(12))
                .foregroundColor(DS.Color.textSecondary)
                .lineLimit(2)
                .textSelection(.enabled)
            Spacer()
        }
        .padding(.horizontal, 12).padding(.vertical, 9)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.xs)
                .fill(DS.Color.bg3)
                .overlay(RoundedRectangle(cornerRadius: DS.Radius.xs)
                    .stroke(DS.Color.cardBorder, lineWidth: 1))
        )
    }
}


