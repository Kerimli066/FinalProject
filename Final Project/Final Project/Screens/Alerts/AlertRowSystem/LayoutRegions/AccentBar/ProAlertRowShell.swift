//
//  ProAlertRowShell.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowShell<Content: View>: View {
    let sevColor: Color
    let index: Int
    let appeared: Bool
    let content: Content

    init(sevColor: Color, index: Int, appeared: Bool, @ViewBuilder content: () -> Content) {
        self.sevColor = sevColor
        self.index = index
        self.appeared = appeared
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ProAlertRowCardBackground(sevColor: sevColor)
            ProAlertRowGlow(sevColor: sevColor)
            content
        }
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 12)
        .animation(
            .spring(response: 0.5, dampingFraction: 0.78)
                .delay(Double(index) * 0.045 + 0.25),
            value: appeared
        )
    }
}