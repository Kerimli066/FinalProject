//
//  ContainerCardMainRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//

import SwiftUI

struct ContainerCardMainRow: View {
    let container: ContainerInfo
    let iconColor: Color
    let iconSymbol: String
    let isSystemCritical: Bool

    var body: some View {
        HStack(spacing: 12) {
            ContainerCardAvatar(
                iconColor: iconColor,
                iconSymbol: iconSymbol,
                isRunning: container.isRunning,
                isSystemCritical: isSystemCritical
            )

            ContainerCardNameBlock(
                name: container.name,
                image: container.image
            )

            Spacer(minLength: 8)

            ContainerCardRightCluster(
                isRunning: container.isRunning,
                stateText: container.state.lowercased()
            )
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
    }
}
