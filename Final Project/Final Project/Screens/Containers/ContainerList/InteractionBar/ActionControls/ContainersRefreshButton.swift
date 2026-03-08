//
//  ContainersRefreshButton.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainersRefreshButton: View {
    let isLoading: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Image(systemName: "arrow.clockwise")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(DS.Color.accent)
                .rotationEffect(.degrees(isLoading ? 360 : 0))
                .animation(
                    isLoading ? .linear(duration: 0.7).repeatForever(autoreverses: false) : .default,
                    value: isLoading
                )
                .frame(width: 30, height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(DS.Color.accent.opacity(0.08))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(DS.Color.accent.opacity(0.22), lineWidth: 1)
                        )
                )
        }
        .buttonStyle(.plain)
    }
}
