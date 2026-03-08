//
//  LogsHUDHeader.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct LogsHUDHeader: View {
    let selectedContainer: ContainerInfo?
    let isStreaming: Bool
    let isPaused: Bool
    let containers: [ContainerInfo]
    let onSelect: (ContainerInfo) -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 3) {
                    Text("Logs")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(DS.Color.textPrimary)

                    HStack(spacing: 5) {
                        Text("real-time stream")
                            .font(DS.Font.mono(11))
                            .foregroundColor(DS.Color.textMuted)

                        if let c = selectedContainer {
                            Text("·")
                                .foregroundColor(DS.Color.textMuted)
                                .font(DS.Font.mono(11))

                            Text(c.name)
                                .font(DS.Font.mono(11))
                                .foregroundColor(DS.Color.accent.opacity(0.9))
                                .lineLimit(1)
                        }
                    }
                }

                Spacer()

                StreamStatusBadge(isStreaming: isStreaming, isPaused: isPaused)
            }

            ContainerPickerView(
                selectedContainer: selectedContainer,
                containers: containers,
                onSelect: onSelect
            )
        }
    }
}
