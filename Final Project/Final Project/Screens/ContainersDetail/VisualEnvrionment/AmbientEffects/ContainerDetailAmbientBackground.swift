//
//  ContainerDetailAmbientBackground.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerDetailAmbientBackground: View {
    let accent: Color

    var body: some View {
        ZStack {
            RadialGradient(
                colors: [accent.opacity(0.08), .clear],
                center: .topLeading,
                startRadius: 0,
                endRadius: 280
            )
            .ignoresSafeArea()

            RadialGradient(
                colors: [DS.Color.accent.opacity(0.04), .clear],
                center: .topTrailing,
                startRadius: 0,
                endRadius: 200
            )
            .ignoresSafeArea()

            ContainerDetailScanlineCanvas()
                .ignoresSafeArea()
        }
    }
}

private struct ContainerDetailScanlineCanvas: View {
    var body: some View {
        Canvas { ctx, size in
            for y in stride(from: 0, to: size.height, by: 3) {
                ctx.fill(
                    Path(CGRect(x: 0, y: y, width: size.width, height: 0.4)),
                    with: .color(.white.opacity(0.011))
                )
            }
        }
        .allowsHitTesting(false)
    }
}