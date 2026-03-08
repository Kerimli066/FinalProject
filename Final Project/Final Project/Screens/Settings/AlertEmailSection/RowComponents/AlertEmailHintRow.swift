//
//  AlertEmailHintRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct AlertEmailHintRow: View {
    var body: some View {
        HStack(spacing: 7) {
            Image(systemName: "arrow.right.circle")
                .font(.system(size: 10))
                .foregroundColor(DS.Color.textTertiary)

            Text("Alerts are sent to your account email when a threshold is breached.")
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(DS.Color.textTertiary)
        }
    }
}
