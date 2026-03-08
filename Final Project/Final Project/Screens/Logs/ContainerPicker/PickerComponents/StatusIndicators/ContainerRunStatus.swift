//
//  ContainerRunStatus.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct ContainerRunStatus: View {
    let isRunning: Bool

    var body: some View {
        HStack(spacing: 5) {
            if isRunning {
                PulseDot(color: DS.Color.success, size: 5)
            } else {
                Circle().fill(DS.Color.textMuted).frame(width: 5, height: 5)
            }

            Text(isRunning ? "running" : "stopped")
                .font(DS.Font.mono(10))
                .foregroundColor(isRunning ? DS.Color.success : DS.Color.textTertiary)
        }
    }
}
