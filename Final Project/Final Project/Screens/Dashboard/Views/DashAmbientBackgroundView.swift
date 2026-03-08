//
//  DashAmbientBackgroundView.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

struct DashAmbientBackgroundView: View {
    let healthColor: Color
    let healthLabel: String

    var body: some View {
        ZStack {
            RadialGradient(
                colors: [DS.Color.accent.opacity(0.11), .clear],
                center: .init(x: 1.0, y: 0.0),
                startRadius: 0, endRadius: 420
            )

            RadialGradient(
                colors: [healthColor.opacity(0.06), .clear],
                center: .init(x: 0.0, y: 0.5),
                startRadius: 0, endRadius: 300
            )
            .animation(DS.Anim.smooth, value: healthLabel)

            Canvas { ctx, size in
                var y: CGFloat = 0
                while y < size.height {
                    let p = Path { path in
                        path.move(to: .init(x: 0, y: y))
                        path.addLine(to: .init(x: size.width, y: y))
                    }
                    ctx.stroke(p, with: .color(.white.opacity(0.018)), lineWidth: 1)
                    y += 8
                }
            }
        }
    }
}
