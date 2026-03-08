//
//  ProAlertRowGlow.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowGlow: View {
    let sevColor: Color

    var body: some View {
        Circle()
            .fill(sevColor.opacity(0.07))
            .frame(width: 80)
            .blur(radius: 20)
            .offset(x: 20, y: -20)
            .clipped()
    }
}