//
//  AmbientBackgroundView.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct AmbientBackgroundView: View {
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [DS.Color.danger.opacity(0.12), .clear],
                center: .init(x: 1.0, y: 0.0),
                startRadius: 0, endRadius: 380
            )
            RadialGradient(
                colors: [DS.Color.warning.opacity(0.06), .clear],
                center: .init(x: 0.0, y: 0.85),
                startRadius: 0, endRadius: 280
            )
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
            .drawingGroup()
        }
    }
}
