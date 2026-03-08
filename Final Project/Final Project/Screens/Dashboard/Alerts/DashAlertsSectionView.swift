//
//  DashAlertsSectionView.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//



import SwiftUI

struct DashAlertsSectionView: View {
    @ObservedObject var vm: DashboardViewModel
    let appeared: Bool
    let onViewAllAlerts: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                SectionHeader(
                    title: "Active Alerts",
                    icon: "bell.badge.fill",
                    badge: "\(vm.recentAlerts.count)"
                )
                Spacer()
                Button { onViewAllAlerts?() } label: {
                    HStack(spacing: 4) {
                        Text("View All")
                            .font(DS.Font.caption(12))
                            .foregroundColor(DS.Color.accent)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(DS.Color.accent)
                    }
                }
            }

            let n = Set(vm.recentAlerts.map(\.containerId)).count
            Text("\(vm.recentAlerts.count) alerts · \(n) containers affected")
                .font(DS.Font.caption(11))
                .foregroundColor(DS.Color.textTertiary)
                .padding(.top, -6)

            VStack(spacing: 8) {
                ForEach(vm.recentAlerts) { alert in
                    DashAlertRow(alert: alert, compact: true)
                }
            }
            .animation(DS.Anim.spring, value: vm.recentAlerts.map(\.id))
        }
        .padding(DS.Space.md)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.lg)
                .fill(DS.Color.bg2)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.lg)
                        .stroke(
                            LinearGradient(
                                colors: [DS.Color.danger.opacity(0.15), DS.Color.cardBorder],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .shadow(color: DS.Color.danger.opacity(0.06), radius: 18, x: 0, y: 6)
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 1)
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 10)
        .animation(.spring(response: 0.55, dampingFraction: 0.8).delay(0.46), value: appeared)
    }
}
