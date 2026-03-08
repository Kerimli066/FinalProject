//
//  ProAlertRowMetricPill.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowMetricPill: View {
    let sevColor: Color
    let isCPU: Bool
    let valueStr: String

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: isCPU ? "cpu" : "memorychip")
                .font(.system(size: 9, weight: .semibold))

            Text(valueStr)
                .font(.system(size: 12, weight: .bold, design: .monospaced))
        }
        .foregroundColor(sevColor)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(sevColor.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(sevColor.opacity(0.16), lineWidth: 1)
                )
        )
    }
}