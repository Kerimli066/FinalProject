//
//  ProAlertRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct ProAlertRow: View {
    let alert: Alert
    let index: Int
    let appeared: Bool

    private var sev: AlertSeverity { AlertSeverityCalculator.severity(for: alert) }

    var body: some View {
        ProAlertRowShell(
            sevColor: sev.color,
            index: index,
            appeared: appeared
        ) {
            ProAlertRowContent(
                alert: alert,
                sev: sev,
                sevColor: sev.color
            )
        }
    }
}
