//
//  ProAlertRowLeftBar.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowLeftBar: View {
    let sevColor: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(
                LinearGradient(
                    colors: [sevColor, sevColor.opacity(0.15)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 3)
            .padding(.vertical, 16)
    }
}