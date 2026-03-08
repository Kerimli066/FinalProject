//
//  NeonBadge.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct NeonBadge: View {
    let text:  String
    let color: Color

    var body: some View {
        Text(text)
            .font(DS.Font.label(9))
            .tracking(0.8)
            .foregroundColor(color)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(
                Capsule()
                    .fill(color.opacity(0.08))
                    .overlay(Capsule().stroke(color.opacity(0.2), lineWidth: 0.8))
            )
            .shadow(color: color.opacity(0.15), radius: 2)
    }
}
