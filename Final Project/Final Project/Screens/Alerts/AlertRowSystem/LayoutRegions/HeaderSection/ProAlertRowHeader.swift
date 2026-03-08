//
//  ProAlertRowHeader.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowHeader: View {
    let containerName: String
    let sevLabel: String
    let sevColor: Color

    var body: some View {
        HStack(spacing: 8) {
            Text(containerName)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(DS.Color.textPrimary)
                .lineLimit(1)

            Spacer()

            Text(sevLabel)
                .font(.system(size: 9, weight: .black, design: .monospaced))
                .foregroundColor(sevColor)
                .tracking(0.6)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(sevColor.opacity(0.10))
                        .overlay(Capsule().stroke(sevColor.opacity(0.22), lineWidth: 1))
                )
        }
    }
}