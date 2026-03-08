//
//  LumenLoadingView.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct LumenLoadingView: View {
    var message: String = "Loading…"
    @State private var rotating = false

    var body: some View {
        VStack(spacing: DS.Space.sm) {
            ZStack {
                Circle()
                    .stroke(DS.Color.accent.opacity(0.12), lineWidth: 2.5)
                    .frame(width: 46, height: 46)
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(DS.Color.accent,
                            style: StrokeStyle(lineWidth: 2.5, lineCap: .round))
                    .frame(width: 46, height: 46)
                    .rotationEffect(.degrees(rotating ? 360 : 0))
                    .animation(
                        .linear(duration: 0.85).repeatForever(autoreverses: false),
                        value: rotating
                    )
            }
            Text(message)
                .font(DS.Font.caption(13))
                .foregroundColor(DS.Color.textSecondary)
        }
        .onAppear { rotating = true }
    }
}
