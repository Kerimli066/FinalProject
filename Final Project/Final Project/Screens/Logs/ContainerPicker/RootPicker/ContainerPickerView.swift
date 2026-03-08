//
//  ContainerPickerView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct ContainerPickerView: View {
    let selectedContainer: ContainerInfo?
    let containers: [ContainerInfo]
    let onSelect: (ContainerInfo) -> Void

    var body: some View {
        Menu {
            ForEach(containers) { c in
                Button { onSelect(c) } label: {
                    Label(
                        c.name + (c.isRunning ? "" : "  (stopped)"),
                        systemImage: c.isRunning ? "circle.fill" : "circle"
                    )
                }
            }
        } label: {
            HStack(spacing: 12) {
                ContainerPickerIcon()

                VStack(alignment: .leading, spacing: 2) {
                    Text("CONTAINER")
                        .font(.system(size: 9, weight: .black, design: .monospaced))
                        .foregroundColor(DS.Color.textMuted)
                        .tracking(1)

                    Text(selectedContainer?.name ?? "Select a container…")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(selectedContainer != nil
                                         ? DS.Color.textPrimary
                                         : DS.Color.textTertiary)
                        .lineLimit(1)
                }

                Spacer()

                if let c = selectedContainer {
                    ContainerRunStatus(isRunning: c.isRunning)
                }

                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(DS.Color.textTertiary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(ContainerPickerCardBackground())
        }
    }
}
