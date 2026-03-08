//
//  LogLevelChip.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct LogLevelChip: View {
    let level: LogLevel
    @Binding var selectedLevel: LogLevel
    let count: Int

    private var isSelected: Bool { selectedLevel == level }

    var body: some View {
        Button {
            withAnimation(DS.Anim.spring) {
                selectedLevel = (isSelected && level != .all) ? .all : level
            }
        } label: {
            HStack(spacing: 5) {
                ZStack {
                    Circle()
                        .fill(isSelected ? Color.white.opacity(0.25) : level.color.opacity(0.15))
                        .frame(width: 18, height: 18)

                    Image(systemName: level.icon)
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(isSelected ? .white : level.color)
                }

                if level == .all {
                    Text("All")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(isSelected ? .white : DS.Color.textSecondary)
                } else {
                    Text(level.tag)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(isSelected ? .white : DS.Color.textSecondary)

                    if count > 0 {
                        Text("\(count)")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundColor(isSelected ? .white.opacity(0.8) : level.color.opacity(0.8))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 1.5)
                            .background(
                                Capsule().fill(
                                    isSelected
                                    ? Color.white.opacity(0.18)
                                    : level.color.opacity(0.15)
                                )
                            )
                    }
                }
            }
            .padding(.horizontal, 11)
            .padding(.vertical, 7)
            .background(background)
            .overlay(
                Capsule().stroke(isSelected ? level.color.opacity(0.5) : DS.Color.cardBorder, lineWidth: 1)
            )
            .shadow(color: isSelected ? level.color.opacity(0.3) : .clear, radius: 8)
        }
        .buttonStyle(.plain)
        .animation(DS.Anim.fast, value: isSelected)
    }

    private var background: some ShapeStyle {
        if isSelected {
            return AnyShapeStyle(
                LinearGradient(
                    colors: level == .all
                    ? [DS.Color.accent, DS.Color.accentSoft]
                    : [level.color.opacity(0.9), level.color.opacity(0.65)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        } else {
            return AnyShapeStyle(DS.Color.bg3)
        }
    }
}
