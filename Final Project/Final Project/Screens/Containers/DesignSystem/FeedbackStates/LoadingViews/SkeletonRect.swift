//
//  SkeletonRect.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct SkeletonRect: View {
    var width:  CGFloat? = nil
    var height: CGFloat  = 14
    var radius: CGFloat  = 6
    @State private var phase: CGFloat = 0

    var body: some View {
        RoundedRectangle(cornerRadius: radius)
            .fill(shimmer)
            .frame(width: width, height: height)
            .onAppear {
                withAnimation(.linear(duration: 1.1).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }

    private var shimmer: LinearGradient {
        LinearGradient(
            colors: [DS.Color.bg2, DS.Color.bg3, DS.Color.bg2],
            startPoint: UnitPoint(x: phase - 0.4, y: 0),
            endPoint:   UnitPoint(x: phase + 0.4, y: 0)
        )
    }
}



