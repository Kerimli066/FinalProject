//
//  ContainersTabBackground.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//

import SwiftUI

struct ContainersTabBackground: View {
    var body: some View {
        DS.Color.bg0
            .ignoresSafeArea()
            .overlay(gridOverlay)
    }

    private var gridOverlay: some View {
        Canvas { ctx, size in
            for y in stride(from: 0, to: size.height, by: 3) {
                ctx.fill(
                    Path(CGRect(x: 0, y: y, width: size.width, height: 0.35)),
                    with: .color(.white.opacity(0.012))
                )
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}
