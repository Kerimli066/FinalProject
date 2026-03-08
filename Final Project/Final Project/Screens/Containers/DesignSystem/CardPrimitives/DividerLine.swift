//
//  DividerLine.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct DividerLine: View {
    var body: some View {
        Rectangle()
            .fill(DS.Color.cardBorder)
            .frame(height: 1)
            .padding(.horizontal, DS.Space.sm)
    }
}