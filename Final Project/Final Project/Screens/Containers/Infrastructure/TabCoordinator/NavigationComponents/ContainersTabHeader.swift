//
//  ContainersTabHeader.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainersTabHeader: View {
    let selectedSegmentTitle: String
    let appeared: Bool

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 3) {
                Text("Infrastructure")
                    .font(.system(size: 26, weight: .black, design: .rounded))
                    .foregroundColor(DS.Color.textPrimary)

                HStack(spacing: 6) {
                    Text("Docker")
                        .font(DS.Font.mono(11))
                        .foregroundColor(DS.Color.textMuted)

                    Text("·")
                        .foregroundColor(DS.Color.textMuted)

                    Text(selectedSegmentTitle.lowercased())
                        .font(DS.Font.mono(11))
                        .foregroundColor(DS.Color.accent)
                        .animation(DS.Anim.smooth, value: selectedSegmentTitle)
                }
            }

            Spacer()

            ContainersLiveBadge()
        }
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : -8)
    }
}
