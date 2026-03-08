//
//  AlertEmailValueRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct AlertEmailValueRow: View {
    let email: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "at")
                .font(.system(size: 15))
                .foregroundColor(DS.Color.accentSoft)
                .frame(width: 20)

            Text(email.isEmpty ? "No email on account" : email)
                .font(.system(size: 15))
                .foregroundColor(email.isEmpty ? DS.Color.textTertiary : DS.Color.textPrimary)
                .lineLimit(1)
                .truncationMode(.middle)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(DS.Color.bg2)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(DS.Color.accentSoft.opacity(0.25), lineWidth: 1)
                )
        )
    }
}
