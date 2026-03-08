//
//  ContainersTabSegmentBar.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainersTabSegmentBar: View {
    typealias Segment = ContainersTabViewModel.Segment

    let selected: Segment
    let onSelect: (Segment) -> Void
    let appeared: Bool

    var body: some View {
        HStack(spacing: 3) {
            ForEach(Segment.allCases, id: \.self) { seg in
                let sel = selected == seg
                Button {
                    onSelect(seg)
                } label: {
                    ContainersSegmentButtonContent(
                        seg: seg,
                        isSelected: sel
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.md)
                .fill(DS.Color.bg3)
                .overlay(
                    RoundedRectangle(cornerRadius: DS.Radius.md)
                        .stroke(DS.Color.cardBorder, lineWidth: 1)
                )
        )
        .opacity(appeared ? 1 : 0)
    }
}
