//
//  ProAlertRowMessage.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowMessage: View {
    let message: String

    var body: some View {
        Text(message)
            .font(DS.Font.caption(12))
            .foregroundColor(DS.Color.textSecondary)
            .lineLimit(1)
    }
}