//
//  ContainerCardRightCluster.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerCardRightCluster: View {
    let isRunning: Bool
    let stateText: String

    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            HStack(spacing: 4) {
                if isRunning { PulseDot(color: DS.Color.success, size: 5) }
                else { Circle().fill(DS.Color.textMuted).frame(width: 5, height: 5) }

                Text(stateText)
                    .font(DS.Font.label(10))
                    .foregroundColor(isRunning ? DS.Color.success : DS.Color.textTertiary)
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(DS.Color.textMuted)
        }
    }
}
