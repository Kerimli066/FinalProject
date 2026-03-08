//
//  ContainerSkeletonAccordions.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerSkeletonAccordions: View {
    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<3, id: \.self) { _ in
                HStack(spacing: 10) {
                    SkeletonRect(width: 30, height: 30, radius: 8)
                    SkeletonRect(width: 100, height: 12)
                    Spacer()
                    SkeletonRect(width: 24, height: 24, radius: 12)
                }
                .padding(.horizontal, DS.Space.sm)
                .padding(.vertical, 13)
                .background(
                    RoundedRectangle(cornerRadius: DS.Radius.lg)
                        .fill(DS.Color.bg2)
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.Radius.lg)
                                .stroke(DS.Color.cardBorder, lineWidth: 1)
                        )
                )
            }
        }
    }
}