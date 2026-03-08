//
//  SignOutCardView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct SignOutCardView: View {
    let onTap: () -> Void

    var body: some View {
        GlowCardView(accent: DS.Color.danger) {
            CardHeaderView(title: "ACCOUNT", icon: "person.crop.circle.fill", color: DS.Color.danger)

            Button(action: onTap) {
                HStack(spacing: 14) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(DS.Color.danger.opacity(0.12))
                            .frame(width: 52, height: 52)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(DS.Color.danger.opacity(0.3), lineWidth: 1)
                            )

                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(DS.Color.danger)
                    }

                    Text("Sign Out")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(DS.Color.danger)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(DS.Color.danger.opacity(0.5))
                }
                .padding(.vertical, 4)
            }
            .buttonStyle(.plain)
        }
    }
}