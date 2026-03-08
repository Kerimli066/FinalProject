//
//  TerminalSeparator.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//



import SwiftUI

struct TerminalSeparator: View {
    let title: String

    var body: some View {
        ZStack {
            Rectangle()
                .fill(DS.Color.cardBorder)
                .frame(height: 1)

            HStack(spacing: 0) {
                Text(" \(title) ")
                    .font(.system(size: 8, weight: .black, design: .monospaced))
                    .foregroundColor(DS.Color.textMuted)
                    .tracking(1.5)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(DS.Color.bg0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 12)
        }
    }
}
