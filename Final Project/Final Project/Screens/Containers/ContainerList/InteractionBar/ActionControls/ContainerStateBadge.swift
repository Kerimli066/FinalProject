//
//  ContainerStateBadge.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct ContainerStateBadge: View {
    let state:     String
    let isRunning: Bool

    var body: some View {
        StatusPill(
            label:   state.lowercased(),
            color:   isRunning ? DS.Color.success : DS.Color.textTertiary,
            pulsing: isRunning
        )
    }
}
