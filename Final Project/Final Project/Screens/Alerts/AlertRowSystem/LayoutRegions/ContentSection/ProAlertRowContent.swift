//
//  ProAlertRowContent.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowContent: View {
    let alert: Alert
    let sev: AlertSeverity
    let sevColor: Color

    private var isCPU: Bool { alert.type.uppercased() == "CPU" }

    private var valueStr: String {
        isCPU
            ? String(format: "%.1f%%", alert.value)
            : (alert.value >= 1024
               ? String(format: "%.1f GB", alert.value / 1024)
               : String(format: "%.0f MB", alert.value))
    }

    var body: some View {
        HStack(spacing: 0) {
            ProAlertRowLeftBar(sevColor: sevColor)

            HStack(spacing: 13) {
                ProAlertRowIcon(sevColor: sevColor, isCPU: isCPU)

                VStack(alignment: .leading, spacing: 6) {
                    ProAlertRowHeader(
                        containerName: alert.containerName,
                        sevLabel: sev.label,
                        sevColor: sevColor
                    )

                    ProAlertRowMessage(message: alert.message)

                    ProAlertRowFooter(
                        sevColor: sevColor,
                        isCPU: isCPU,
                        valueStr: valueStr,
                        timestamp: alert.timestamp
                    )
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
        }
    }
}