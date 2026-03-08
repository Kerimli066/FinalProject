//
//  HealthScoreRing.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct HealthScoreRing: View {
    let score:  Int
    let status: HealthStatus

    @State private var ringProgress: Double = 0
    @State private var glowPulse:    Bool   = false
    @State private var isVisible:    Bool   = false

    private var progress: Double { Double(score) / 100.0 }

    var body: some View {
        ZStack {
            DS.Gradient.healthGlow(status.color)
                .clipShape(Circle())
                .frame(width: 170, height: 170)
                .scaleEffect(glowPulse ? 1.3 : 0.8)
                .animation(
                    isVisible
                        ? Animation.easeInOut(duration: 3.0).repeatForever(autoreverses: true)
                        : .default,
                    value: glowPulse
                )

            Circle()
                .stroke(
                    AngularGradient(
                        colors: [
                            status.color.opacity(0.0),
                            status.color.opacity(0.15),
                            status.color.opacity(0.0)
                        ],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 1)
                )
                .frame(width: 152, height: 152)

            Circle()
                .stroke(DS.Color.bg4, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .frame(width: 130, height: 130)

            Circle()
                .trim(from: 0, to: ringProgress)
                .stroke(
                    AngularGradient(
                        colors: [
                            status.color.opacity(0.4),
                            status.color,
                            status.color.opacity(0.8)
                        ],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .frame(width: 130, height: 130)
                .rotationEffect(.degrees(-90))
                .shadow(color: status.color.opacity(0.7), radius: 12)
                .animation(DS.Anim.slow.delay(0.1), value: ringProgress)

            VStack(spacing: 2) {
                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(status.color)
                    .shadow(color: status.color.opacity(0.7), radius: 6)
                Text("\(score)")
                    .font(DS.Font.display(40))
                    .foregroundColor(DS.Color.textPrimary)
                    .contentTransition(.numericText())
                    .animation(DS.Anim.smooth, value: score)
                Text("HEALTH")
                    .font(DS.Font.label(9))
                    .foregroundColor(DS.Color.textTertiary)
                    .tracking(3.0)
            }
        }
        .onAppear {
            isVisible = true
            withAnimation(DS.Anim.slow.delay(0.1)) {
                ringProgress = progress
            }
            glowPulse = true
        }
        .onDisappear {
            isVisible = false
            glowPulse = false
        }
        .onChange(of: score) { _, newValue in
            withAnimation(DS.Anim.smooth) {
                ringProgress = Double(newValue) / 100.0
            }
        }
        .onChange(of: status) { _, _ in
            guard isVisible else { return }
            glowPulse = false
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 50_000_000)
                glowPulse = true
            }
        }
    }
}
