//
//  DashHealthCardView.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

struct DashHealthCardView: View {
    @ObservedObject var vm: DashboardViewModel
    let appeared: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DS.Radius.card)
                .fill(DS.Color.bg2)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.card)
                        .stroke(
                            LinearGradient(
                                colors: [vm.healthStatus.color.opacity(0.22), DS.Color.cardBorder],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: vm.healthStatus.color.opacity(0.08), radius: 28, x: 0, y: 10)
                .shadow(color: .black.opacity(0.18), radius: 6, x: 0, y: 2)

            VStack {
                LinearGradient(
                    colors: [vm.healthStatus.color.opacity(0.09), .clear],
                    startPoint: .top, endPoint: .bottom
                )
                .frame(height: 90)
                .clipShape(RoundedRectangle(cornerRadius: DS.Radius.card))
                Spacer()
            }

            Circle()
                .fill(vm.healthStatus.color.opacity(0.09))
                .frame(width: 130)
                .blur(radius: 30)
                .offset(x: 80, y: -45)
                .animation(DS.Anim.smooth, value: vm.healthStatus.label)

            VStack(spacing: 20) {
                HealthScoreRing(score: vm.healthScore, status: vm.healthStatus)

                VStack(spacing: 6) {
                    if vm.isCalculatingHealth {
                        HStack(spacing: 8) {
                            ProgressView()
                                .scaleEffect(0.7)
                                .tint(DS.Color.accent)
                            Text("Calculating…")
                                .font(DS.Font.caption(13))
                                .foregroundColor(DS.Color.textTertiary)
                        }
                    } else {
                        Text(vm.healthStatus.label)
                            .font(DS.Font.title(18))
                            .foregroundColor(vm.healthStatus.color)
                            .shadow(color: vm.healthStatus.color.opacity(0.5), radius: 10)
                            .contentTransition(.opacity)
                            .animation(DS.Anim.smooth, value: vm.healthStatus.label)
                    }

                    HStack(spacing: 10) {
                        StatPill(
                            icon: "server.rack",
                            text: "\(vm.runningCount) running",
                            color: DS.Color.success
                        )
                        StatPill(
                            icon: "exclamationmark.triangle.fill",
                            text: "\(vm.criticalCount) critical",
                            color: vm.criticalCount > 0 ? DS.Color.danger : DS.Color.textTertiary
                        )
                    }
                }
            }
            .padding(.vertical, 30)
        }
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 10)
        .animation(.spring(response: 0.55, dampingFraction: 0.8).delay(0.25), value: appeared)
    }
}
