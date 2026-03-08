//
//  MiniProgressBar.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct MiniProgressBar: View {
    let ratio: Double
    let color: Color
    var width: CGFloat = 60
    var height: CGFloat = 3
    var minFill: CGFloat = 4

    var body: some View {
        GeometryReader { g in
            ZStack(alignment: .trailing) {
                Capsule().fill(DS.Color.bg4).frame(height: height)

                Capsule().fill(color)
                    .frame(
                        width: max(minFill, g.size.width * CGFloat(clamped(ratio))),
                        height: height
                    )
                    .shadow(color: color.opacity(0.5), radius: 3)
            }
        }
        .frame(width: width, height: height)
    }

    private func clamped(_ x: Double) -> Double {
        min(1, max(0, x))
    }
}