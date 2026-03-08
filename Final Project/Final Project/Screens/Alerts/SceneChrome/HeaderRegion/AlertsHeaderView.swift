//
//  AlertsHeaderView.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct AlertsHeaderView: View {
    @ObservedObject var vm: AlertViewModel
    let appeared: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Top Row (Status + Clear Button)
            HStack(alignment: .center) {
                AlertsStatusPill(isLoading: vm.isLoading)

                Spacer()

                AlertsClearAllButton(
                    appeared: appeared,
                    isHidden: vm.alerts.isEmpty,
                    onTap: { vm.showClearConfirm = true }
                )
            }
            .padding(.bottom, 18)

            // Title Row
            HStack(alignment: .lastTextBaseline, spacing: 14) {

                Text("Alerts")
                    .font(.system(size: 44, weight: .black, design: .rounded))
                    .foregroundColor(DS.Color.textPrimary)
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 16)
                    .animation(
                        .spring(response: 0.55, dampingFraction: 0.8)
                        .delay(0.08),
                        value: appeared
                    )

                if !vm.alerts.isEmpty {
                    Text("\(vm.alerts.count)")
                        .font(.system(size: 26, weight: .black, design: .monospaced))
                        .foregroundColor(DS.Color.danger.opacity(0.6))
                        .padding(.bottom, 3)
                        .opacity(appeared ? 1 : 0)
                        .animation(
                            .easeOut(duration: 0.35)
                            .delay(0.18),
                            value: appeared
                        )
                }
            }
            .padding(.bottom, 14)

            // Severity Pills
            if !vm.alerts.isEmpty {
                HStack(spacing: 8) {
                    SeverityPill(
                        color: DS.Color.alertCritical,
                        count: vm.criticalCount,
                        label: "Critical"
                    )

                    SeverityPill(
                        color: DS.Color.alertHigh,
                        count: vm.highCount,
                        label: "High"
                    )

                    SeverityPill(
                        color: DS.Color.alertMedium,
                        count: vm.mediumCount,
                        label: "Medium"
                    )
                }
                .opacity(appeared ? 1 : 0)
                .animation(
                    .easeOut(duration: 0.35)
                    .delay(0.22),
                    value: appeared
                )
            } else {
                Text("No alerts recorded")
                    .font(DS.Font.caption(12))
                    .foregroundColor(DS.Color.textTertiary)
            }
        }
    }
}
