//
//  PulseDot.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

public struct PulseDot: View {
    public var color:          Color
    public var size:           CGFloat
    public var pulseScale:     CGFloat
    public var pulseOpacity:   Double
    public var pulseDuration:  Double

    @State private var animate = false

    public init(
        color:         Color,
        size:          CGFloat = 8,
        pulseScale:    CGFloat = 2.2,
        pulseOpacity:  Double  = 0.25,
        pulseDuration: Double  = 1.2
    ) {
        self.color         = color
        self.size          = size
        self.pulseScale    = pulseScale
        self.pulseOpacity  = pulseOpacity
        self.pulseDuration = pulseDuration
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: size, height: size)

            Circle()
                .stroke(color.opacity(pulseOpacity), lineWidth: max(1, size * 0.15))
                .frame(width: size, height: size)
                .scaleEffect(animate ? pulseScale : 1)
                .opacity(animate ? 0 : 1)
                .animation(
                    .easeOut(duration: pulseDuration).repeatForever(autoreverses: false),
                    value: animate
                )
        }
        .onAppear { animate = true }
        .accessibilityHidden(true)
    }
}

#Preview("PulseDot") {
    VStack(spacing: 16) {
        PulseDot(color: .green)
        PulseDot(color: .red,  size: 10)
        PulseDot(color: .blue, size: 12, pulseScale: 2.6)
    }
    .padding()
    .background(Color.black)
}
