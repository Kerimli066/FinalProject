//
//  SeverityPill.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct SeverityPill: View {
    let color: Color
    let count: Int
    let label: String

    var body: some View {
        HStack(spacing: 5) {
            Circle().fill(color).frame(width: 5, height: 5)
            Text("\(count) \(label)")
                .font(DS.Font.label(10))
                .foregroundColor(color.opacity(0.9))
        }
        .padding(.horizontal, 9).padding(.vertical, 4)
        .background(
            Capsule()
                .fill(color.opacity(0.08))
                .overlay(Capsule().stroke(color.opacity(0.2), lineWidth: 1))
        )
        .opacity(count > 0 ? 1.0 : 0.3)
    }
}
