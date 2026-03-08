//
//  SettingsHeroTopRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct SettingsHeroTopRow: View {
    let appeared: Bool
    let connectionColor: Color
    let connectionText: String

    var body: some View {
        HStack(alignment: .center, spacing: 12) {

            SettingsHeroIcon(appeared: appeared)

            SettingsHeroModeLabels(appeared: appeared)

            Spacer()

            ConnectionStatusCapsule(
                appeared: appeared,
                color: connectionColor,
                text: connectionText
            )
        }
    }
}
