//
//  AlertsErrorBanner.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

struct AlertsErrorBanner: View {
    let message: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(DS.Color.warning)

            Text(message)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(DS.Color.textSecondary)
                .lineLimit(2)

            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.md)
                .fill(DS.Color.bg2)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.md)
                        .stroke(DS.Color.warning.opacity(0.22), lineWidth: 1)
                )
        )
    }
}