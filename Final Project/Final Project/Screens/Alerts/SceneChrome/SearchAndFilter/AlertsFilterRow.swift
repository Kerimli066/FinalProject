//
//  AlertsFilterRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct AlertsFilterRow: View {
    @ObservedObject var vm: AlertViewModel
    let appeared: Bool

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(AlertFilterType.allCases, id: \.self) { f in
                    filterChip(f)
                }
            }
            .padding(.horizontal, 20)
        }
        .opacity(appeared ? 1 : 0)
        .animation(.easeOut(duration: 0.35).delay(0.32), value: appeared)
    }

    private func filterChip(_ f: AlertFilterType) -> some View {
        let sel   = vm.selectedType == f
        let count = vm.count(for: f)
        let color = f.accentColor

        return Button {
            withAnimation(DS.Anim.spring) { vm.selectedType = f }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: f.icon)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(sel ? .white : color.opacity(0.8))

                Group {
                    if let count {
                        Text("\(f.label) · \(count)")
                    } else {
                        Text(f.label)
                    }
                }
                .font(.system(size: 11, weight: sel ? .bold : .medium))
                .foregroundColor(sel ? .white : DS.Color.textSecondary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                ZStack {
                    Capsule().fill(sel ? color : DS.Color.bg2)
                    if sel {
                        Capsule().fill(
                            LinearGradient(
                                colors: [.white.opacity(0.15), .clear],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
                    Capsule().stroke(sel ? Color.clear : DS.Color.cardBorder, lineWidth: 1)
                }
            )
            .shadow(color: sel ? color.opacity(0.35) : .clear, radius: 8, x: 0, y: 3)
        }
        .buttonStyle(.plain)
        .animation(DS.Anim.spring, value: sel)
    }
}
