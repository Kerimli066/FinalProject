//
//  ContainerActionButton.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerActionButton: View {
    let label: String
    let icon: String
    let color: Color
    let disabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 11, weight: .bold))
                Text(label)
                    .font(DS.Font.headline(13))
            }
            .foregroundColor(disabled ? DS.Color.textMuted : color)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 13)
            .background(
                RoundedRectangle(cornerRadius: DS.Radius.sm)
                    .fill(disabled ? DS.Color.bg3 : color.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.Radius.sm)
                            .stroke(disabled ? DS.Color.cardBorder : color.opacity(0.25), lineWidth: 1)
                    )
                    .shadow(color: disabled ? .clear : color.opacity(0.12), radius: 7, x: 0, y: 3)
            )
        }
        .disabled(disabled)
        .animation(DS.Anim.fast, value: disabled)
        .buttonStyle(.plain)
    }
}