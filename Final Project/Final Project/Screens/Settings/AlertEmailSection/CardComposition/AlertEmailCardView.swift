//
//  AlertEmailCardView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct AlertEmailCardView: View {
    let recipientEmail: String

    var body: some View {
        GlowCardView(accent: DS.Color.accentSoft) {
            CardHeaderView(title: "ALERT EMAIL", icon: "envelope.fill", color: DS.Color.accentSoft)

            VStack(spacing: 14) {
                AlertEmailTopRow()
                AlertEmailValueRow(email: recipientEmail)
                AlertEmailHintRow()
            }
            .padding(.bottom, 4)
        }
    }
}
