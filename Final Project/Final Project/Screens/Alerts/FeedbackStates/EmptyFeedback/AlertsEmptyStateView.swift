//
//  AlertsEmptyStateView.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct AlertsEmptyStateView: View {
    let searchText: String

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(DS.Color.success.opacity(0.07))
                        .frame(width: 110, height: 110)
                        .blur(radius: 12)
                    Circle()
                        .stroke(DS.Color.success.opacity(0.15), lineWidth: 1)
                        .frame(width: 88, height: 88)
                    Circle()
                        .fill(DS.Color.bg2)
                        .frame(width: 80, height: 80)
                    Image(systemName: "checkmark.shield.fill")
                        .font(.system(size: 32, weight: .regular))
                        .foregroundColor(DS.Color.success.opacity(0.75))
                        .shadow(color: DS.Color.success.opacity(0.4), radius: 12)
                }

                VStack(spacing: 7) {
                    Text("All Clear")
                        .font(.system(size: 22, weight: .black, design: .rounded))
                        .foregroundColor(DS.Color.textPrimary)

                    Text(searchText.isEmpty
                         ? "No alerts recorded"
                         : "No results for '\(searchText)'")
                        .font(DS.Font.caption(13))
                        .foregroundColor(DS.Color.textTertiary)
                        .multilineTextAlignment(.center)
                }
            }
            Spacer()
        }
    }
}