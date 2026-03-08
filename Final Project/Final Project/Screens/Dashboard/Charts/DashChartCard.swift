//
//  DashChartCard.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

struct DashChartCard<Content: View>: View {
    let title: String
    let subtitle: String
    let content: Content

    init(
        title: String,
        subtitle: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.Space.xs) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(DS.Font.headline())
                        .foregroundColor(DS.Color.textPrimary)

                    Text(subtitle)
                        .font(DS.Font.caption())
                        .foregroundColor(DS.Color.textSecondary)
                }
                .padding(.bottom, 4)

                content
            }
        }
    }
}
