//
//  AppRowView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct AppRowView: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(DS.Color.textSecondary)

            Spacer()

            Text(value)
                .font(.system(size: 13, weight: .medium, design: .monospaced))
                .foregroundColor(DS.Color.textTertiary)
        }
        .padding(.vertical, 13)
    }
}
