//
//  ProAlertRowTime.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowTime: View {
    let timestamp: Date

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "clock")
                .font(.system(size: 9))

            Text(AlertTimeFormatter.relativeTime(timestamp))
                .font(.system(size: 11, weight: .medium, design: .monospaced))
        }
        .foregroundColor(DS.Color.textTertiary)
    }
}