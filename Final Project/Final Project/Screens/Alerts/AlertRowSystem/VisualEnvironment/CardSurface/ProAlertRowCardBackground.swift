//
//  ProAlertRowCardBackground.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowCardBackground: View {
    let sevColor: Color

    var body: some View {
        RoundedRectangle(cornerRadius: DS.Radius.lg)
            .fill(DS.Color.bg2)
            .overlay(
                LinearGradient(
                    colors: [sevColor.opacity(0.07), .clear],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .clipShape(RoundedRectangle(cornerRadius: DS.Radius.lg))
            )
            .overlay(
                RoundedRectangle(cornerRadius: DS.Radius.lg)
                    .stroke(sevColor.opacity(0.14), lineWidth: 1)
            )
            .shadow(color: sevColor.opacity(0.07), radius: 14, x: 0, y: 5)
            .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 1)
    }
}