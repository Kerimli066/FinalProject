//
//  DashAlertRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct DashAlertRow: View {
    let alert:   Alert
    var compact: Bool = false

    private var severity: DashAlertSeverity {
        DashAlertSeverity.fromAlert(type: alert.type, value: alert.value) 
    }
    private var isCPU: Bool { alert.type.uppercased() == "CPU" }

    private var valueStr: String {
        isCPU ? String(format: "%.1f%%", alert.value)
              : String(format: "%.0f MB", alert.value)
    }

    private var timeStr: String {
        let diff = Date().timeIntervalSince(alert.timestamp)
        if diff < 60    { return "Just now" }
        if diff < 3600  { return "\(Int(diff / 60))m ago" }
        if diff < 86400 { return "\(Int(diff / 3600))h ago" }
        let f = DateFormatter(); f.dateStyle = .short; f.timeStyle = .short
        return f.string(from: alert.timestamp)
    }

    var body: some View {
        HStack(spacing: DS.Space.sm) {
            ZStack {
                RoundedRectangle(cornerRadius: DS.Radius.xs)
                    .fill(severity.color.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.Radius.xs)
                            .stroke(severity.color.opacity(0.2), lineWidth: 1)
                    )
                    .frame(width: compact ? 34 : 40, height: compact ? 34 : 40)
                Image(systemName: isCPU ? "cpu" : "memorychip")
                    .font(.system(size: compact ? 13 : 15, weight: .semibold))
                    .foregroundColor(severity.color)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(alert.containerName)
                    .font(DS.Font.headline(compact ? 13 : 14))
                    .foregroundColor(DS.Color.textPrimary)
                    .lineLimit(1)
                Text(alert.message)
                    .font(DS.Font.caption(compact ? 11 : 12))
                    .foregroundColor(DS.Color.textSecondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 3) {
                Text(timeStr)
                    .font(DS.Font.caption(10))
                    .foregroundColor(DS.Color.textTertiary)
                Text(valueStr)
                    .font(DS.Font.headline(compact ? 13 : 14))
                    .foregroundColor(severity.color)
                    .shadow(color: severity.color.opacity(0.35), radius: 4)
            }
        }
        .padding(compact ? 10 : DS.Space.md)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.md)
                .fill(DS.Color.bg3)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.md)
                        .stroke(severity.color.opacity(0.15), lineWidth: 1)
                )
        )
    }
}
