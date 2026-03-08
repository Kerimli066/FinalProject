//
//  ContainersSegmentButtonContent.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainersSegmentButtonContent: View {
    typealias Segment = ContainersTabViewModel.Segment

    let seg: Segment
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: seg.sfIcon)
                .font(.system(size: isSelected ? 13 : 11, weight: .semibold))
                .foregroundColor(isSelected ? .white : DS.Color.textMuted)

            Text(seg.title)
                .font(DS.Font.label(isSelected ? 11 : 10))
                .foregroundColor(isSelected ? .white : DS.Color.textMuted)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 9)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.sm)
                .fill(isSelected ? DS.Color.accent : Color.clear)
                .shadow(color: isSelected ? DS.Color.accent.opacity(0.35) : .clear, radius: 8)
        )
    }
}
