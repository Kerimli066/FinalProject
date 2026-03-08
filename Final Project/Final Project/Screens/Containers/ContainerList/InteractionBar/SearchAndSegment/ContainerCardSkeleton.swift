//
//  ContainerCardSkeleton.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ContainerCardSkeleton: View {
    var body: some View {
        HStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 2).fill(DS.Color.bg4).frame(width: 3).padding(.vertical, 12)
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    SkeletonRect(width: 44, height: 44, radius: 10)
                    VStack(alignment: .leading, spacing: 6) {
                        SkeletonRect(width: 110, height: 12)
                        SkeletonRect(width: 75, height: 9)
                    }
                    Spacer()
                    SkeletonRect(width: 60, height: 20, radius: 10)
                }
                .padding(.horizontal, 14).padding(.vertical, 12)
                Rectangle().fill(DS.Color.cardBorder).frame(height: 1)
                HStack(spacing: 0) {
                    SkeletonRect(height: 8, radius: 4).frame(maxWidth: .infinity).padding(.horizontal, 14)
                    Rectangle().fill(DS.Color.cardBorder).frame(width: 1, height: 28)
                    SkeletonRect(height: 8, radius: 4).frame(maxWidth: .infinity).padding(.horizontal, 14)
                }
                .padding(.vertical, 11)
            }
        }
        .background(RoundedRectangle(cornerRadius: DS.Radius.md).fill(DS.Color.bg2)
            .overlay(RoundedRectangle(cornerRadius: DS.Radius.md).stroke(DS.Color.cardBorder, lineWidth: 1)))
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md))
    }
}

