//
//  AlertsClearAllButton.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct AlertsClearAllButton: View {
    let appeared: Bool
    let isHidden: Bool
    let onTap: () -> Void

    var body: some View {
        if !isHidden {
            Button(action: onTap) {
                HStack(spacing: 5) {
                    Image(systemName: "trash")
                        .font(.system(size: 11, weight: .semibold))
                    Text("Clear All")
                        .font(.system(size: 11, weight: .semibold))
                }
                .foregroundColor(DS.Color.danger)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(DS.Color.danger.opacity(0.08))
                        .overlay(Capsule().stroke(DS.Color.danger.opacity(0.22), lineWidth: 1))
                )
            }
            .buttonStyle(.plain)
            .opacity(appeared ? 1 : 0)
            .animation(.easeOut(duration: 0.3).delay(0.2), value: appeared)
        }
    }
}