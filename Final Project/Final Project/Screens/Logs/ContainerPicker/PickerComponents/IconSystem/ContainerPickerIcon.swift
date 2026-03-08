//
//  ContainerPickerIcon.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct ContainerPickerIcon: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [DS.Color.accent.opacity(0.2), DS.Color.accent.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 40, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(DS.Color.accent.opacity(0.28), lineWidth: 1)
                )

            Image(systemName: "terminal.fill")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(DS.Color.accent)
                .shadow(color: DS.Color.accent.opacity(0.5), radius: 5)
        }
    }
}