//
//  CardHeaderView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct CardHeaderView: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 2).fill(color).frame(width: 3, height: 16)
            Image(systemName: icon).font(.system(size: 11, weight: .bold)).foregroundColor(color.opacity(0.9))
            Text(title)
                .font(.system(size: 11, weight: .black, design: .monospaced))
                .foregroundColor(DS.Color.textTertiary)
                .tracking(1.6)
            Spacer()
        }
        .padding(.bottom, 18)
    }
}
