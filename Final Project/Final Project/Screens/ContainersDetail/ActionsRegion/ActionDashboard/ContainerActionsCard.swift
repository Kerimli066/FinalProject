//
//  ContainerActionsCard.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerActionsCard: View {
    @ObservedObject var vm: ContainerDetailViewModel
    let isSystemCritical: Bool

    var body: some View {
        VStack(spacing: 0) {
            header
            DividerLine()
            actionsGrid
        }
        .background(ContainerDetailCard(glow: nil))
    }

    private var header: some View {
        HStack(spacing: 6) {
            Image(systemName: "bolt.fill")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(DS.Color.accent)

            Text("ACTIONS")
                .font(DS.Font.label(11))
                .foregroundColor(DS.Color.textSecondary)
                .tracking(1.0)

            Spacer()

            if vm.isActionLoading {
                HStack(spacing: 5) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: DS.Color.accent))
                        .scaleEffect(0.65)

                    Text("Processing…")
                        .font(DS.Font.caption(11))
                        .foregroundColor(DS.Color.textTertiary)
                }
            }
        }
        .padding(DS.Space.sm)
    }

    private var actionsGrid: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                ContainerActionButton(
                    label: "Start",
                    icon: "play.fill",
                    color: DS.Color.success,
                    disabled: vm.container.isRunning || vm.isActionLoading
                ) {
                    Task { await vm.startContainer() }
                }

                ContainerActionButton(
                    label: "Stop",
                    icon: "stop.fill",
                    color: isSystemCritical ? DS.Color.textMuted : DS.Color.danger,
                    disabled: !vm.container.isRunning || vm.isActionLoading || isSystemCritical
                ) {
                    Task { await vm.stopContainer() }
                }
            }

            HStack(spacing: 8) {
                ContainerActionButton(
                    label: "Restart",
                    icon: "arrow.clockwise",
                    color: isSystemCritical ? DS.Color.textMuted : DS.Color.warning,
                    disabled: vm.isActionLoading || isSystemCritical
                ) {
                    Task { await vm.restartContainer() }
                }

                ContainerActionButton(
                    label: "Remove",
                    icon: "trash",
                    color: isSystemCritical ? DS.Color.textMuted : DS.Color.danger,
                    disabled: vm.isActionLoading || isSystemCritical
                ) {
                    vm.showRemoveConfirm = true
                }
            }

            if isSystemCritical {
                ContainerLockedNote()
            }
        }
        .padding(DS.Space.sm)
    }
}

private struct ContainerLockedNote: View {
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "lock.fill")
                .font(.system(size: 9))
                .foregroundColor(DS.Color.accent.opacity(0.5))

            Text("Destructive actions are locked for lumen-app.")
                .font(DS.Font.mono(10))
                .foregroundColor(DS.Color.textMuted)
        }
        .padding(9)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.xs)
                .fill(DS.Color.accent.opacity(0.04))
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.xs)
                        .stroke(DS.Color.accent.opacity(0.12), lineWidth: 1)
                )
        )
    }
}