//
//  LogsErrorBanner.swift
//  Final Project
//
//  Created by SabinaKarimli on 06.03.26.
//



import SwiftUI

struct LogsErrorBanner: View {
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
            RoundedRectangle(cornerRadius: 10)
                .fill(DS.Color.bg2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(DS.Color.warning.opacity(0.22), lineWidth: 1)
                )
        )
    }
}
