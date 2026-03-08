//
//  InlineInfoRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct InlineInfoRow: View {
    let icon: String
    let iconSize: CGFloat
    let iconColor: Color
    let text: String
    let textFont: Font
    let textColor: Color

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: iconSize))
                .foregroundColor(iconColor)

            Text(text)
                .font(textFont)
                .foregroundColor(textColor)
        }
    }
}