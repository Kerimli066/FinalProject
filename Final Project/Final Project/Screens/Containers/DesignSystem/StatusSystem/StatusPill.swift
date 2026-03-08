//
//  StatusPill.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct StatusPill: View {
    let label:   String
    let color:   Color
    var pulsing: Bool = false

    var body: some View {
        HStack(spacing: 5) {
            if pulsing { PulseDot(color: color, size: 5) }
            else       { Circle().fill(color).frame(width: 5, height: 5) }
            Text(label)
                .font(DS.Font.label(10))
                .foregroundColor(color)
        }
        .padding(.horizontal, 8).padding(.vertical, 4)
        .background(
            Capsule()
                .fill(color.opacity(0.09))
                .overlay(Capsule().stroke(color.opacity(0.22), lineWidth: 1))
        )
    }
}


