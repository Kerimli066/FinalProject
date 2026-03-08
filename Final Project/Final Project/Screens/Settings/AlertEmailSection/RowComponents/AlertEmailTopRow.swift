//
//  AlertEmailTopRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct AlertEmailTopRow: View {
    var body: some View {
        HStack {
            Text("Notifications will be sent to")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(DS.Color.textSecondary)
            Spacer()
        }
    }
}
