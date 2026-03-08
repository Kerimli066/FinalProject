//
//  DashHeaderRowView.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

struct DashHeaderRowView: View {
    @ObservedObject var vm: DashboardViewModel
    let appeared: Bool

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 7) {
                    ZStack {
                        Circle()
                            .fill(DS.Color.success.opacity(0.2))
                            .frame(width: 10, height: 10)
                        Circle()
                            .fill(DS.Color.success)
                            .frame(width: 6, height: 6)
                    }
                    Text("LIVE")
                        .font(.system(size: 10, weight: .black, design: .monospaced))
                        .foregroundColor(DS.Color.success)
                        .tracking(2.5)
                }
                .padding(.horizontal, 12).padding(.vertical, 7)
                .background(
                    Capsule()
                        .fill(DS.Color.success.opacity(0.07))
                        .overlay(Capsule().stroke(DS.Color.success.opacity(0.2), lineWidth: 1))
                )
                .padding(.bottom, 14)
                .opacity(appeared ? 1 : 0)
                .animation(.easeOut(duration: 0.3).delay(0.05), value: appeared)

                HStack(alignment: .lastTextBaseline, spacing: 14) {
                    Text("Dashboard")
                        .font(.system(size: 44, weight: .black, design: .rounded))
                        .foregroundColor(DS.Color.textPrimary)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 16)
                        .animation(.spring(response: 0.55, dampingFraction: 0.8).delay(0.08), value: appeared)

                    Text("\(vm.containers.count)")
                        .font(.system(size: 26, weight: .black, design: .monospaced))
                        .foregroundColor(DS.Color.accent.opacity(0.5))
                        .padding(.bottom, 3)
                        .opacity(appeared ? 1 : 0)
                        .animation(.easeOut(duration: 0.35).delay(0.18), value: appeared)
                }

                Text("Pocket Lumen")
                    .font(DS.Font.caption(11))
                    .foregroundColor(DS.Color.textTertiary)
                    .tracking(0.5)
                    .padding(.top, 4)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.3).delay(0.22), value: appeared)
            }

            Spacer()

            VStack(spacing: 8) {
                Button { vm.refresh() } label: {
                    ZStack {
                        Circle()
                            .fill(DS.Color.bg4)
                            .overlay(Circle().stroke(DS.Color.cardBorderAlt, lineWidth: 1))
                            .frame(width: 44, height: 44)

                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(DS.Color.accent)
                            .rotationEffect(.degrees(vm.isRefreshing ? 360 : 0))
                            .animation(
                                vm.isRefreshing
                                    ? .linear(duration: 0.8).repeatForever(autoreverses: false)
                                    : .default,
                                value: vm.isRefreshing
                            )
                    }
                }

                HStack(spacing: 4) {
                    Image(systemName: "shippingbox.fill")
                        .font(.system(size: 9))
                        .foregroundColor(DS.Color.textTertiary)
                    Text("\(vm.containers.count)")
                        .font(DS.Font.label(10))
                        .foregroundColor(DS.Color.textSecondary)
                }
            }
            .opacity(appeared ? 1 : 0)
            .animation(.easeOut(duration: 0.3).delay(0.15), value: appeared)
        }
    }
}
