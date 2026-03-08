//
//  ProAlertRowIcon.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowIcon: View {
    let sevColor: Color
    let isCPU: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .fill(sevColor.opacity(0.10))
                .overlay(
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(sevColor.opacity(0.2), lineWidth: 1)
                )
                .frame(width: 44, height: 44)

            Image(systemName: isCPU ? "cpu" : "memorychip")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(sevColor)
                .shadow(color: sevColor.opacity(0.5), radius: 6)
        }
    }
}