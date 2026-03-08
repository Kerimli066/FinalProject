//
//  LumenProgressBar.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct LumenProgressBar: View {
    let progress: Double
    let color:    Color
    var height:   CGFloat = 6
    var showGlow: Bool     = true

    var body: some View {
        GeometryReader { g in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(DS.Color.bg4)
                    .frame(height: height)
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [color.opacity(0.6), color, color.opacity(0.85)],
                            startPoint: .leading, endPoint: .trailing
                        )
                    )
                    .frame(
                        width: max(0, g.size.width * CGFloat(min(max(progress, 0), 1))),
                        height: height
                    )
                    .shadow(color: showGlow ? color.opacity(0.5) : .clear, radius: 5)
                    .animation(DS.Anim.smooth, value: progress)
            }
        }
        .frame(height: height)
    }
}

