//
//  AccordionSection.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct AccordionSection<Content: View>: View {
    let title:     String
    let icon:      String
    let iconColor: Color
    let count:     Int
    @Binding var isExpanded: Bool
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            Button {
                withAnimation(DS.Anim.spring) { isExpanded.toggle() }
            } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(iconColor.opacity(0.1))
                            .frame(width: 30, height: 30)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(iconColor.opacity(0.2), lineWidth: 1))
                        Image(systemName: icon)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(iconColor)
                    }
                    Text(title)
                        .font(DS.Font.headline(14))
                        .foregroundColor(DS.Color.textPrimary)
                    Spacer()
                    Text("\(count)")
                        .font(DS.Font.monoSemibold(11))
                        .foregroundColor(DS.Color.textTertiary)
                        .padding(.horizontal, 8).padding(.vertical, 3)
                        .background(Capsule().fill(DS.Color.bg4))
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(DS.Color.textTertiary)
                }
                .padding(.horizontal, DS.Space.sm)
                .padding(.vertical, 14)
            }
            .buttonStyle(.plain)

            if isExpanded {
                Rectangle()
                    .fill(DS.Color.cardBorder)
                    .frame(height: 1)
                    .padding(.horizontal, DS.Space.sm)
                VStack(spacing: 6) { content() }
                    .padding(DS.Space.sm)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .proCard()
    }
}

