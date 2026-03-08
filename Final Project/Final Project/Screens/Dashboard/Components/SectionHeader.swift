//
//  SectionHeader.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//



import SwiftUI

struct SectionHeader: View {
    let title: String
    let icon: String
    var badge: String? = nil

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(DS.Color.accent)
            Text(title)
                .font(DS.Font.headline(15))
                .foregroundColor(DS.Color.textPrimary)
            if let badge {
                Text(badge)
                    .font(DS.Font.label(10))
                    .foregroundColor(DS.Color.accent)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 2)
                    .background(
                        Capsule()
                            .fill(DS.Color.accent.opacity(0.15))
                            .overlay(Capsule().stroke(DS.Color.accent.opacity(0.3), lineWidth: 1))
                    )
            }
        }
    }
}
