//
//  DashChartEmptyState.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//

import SwiftUI

struct DashChartEmptyState: View {
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 8) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 30))
                    .foregroundColor(DS.Color.textTertiary)

                Text("Collecting data…")
                    .font(DS.Font.caption())
                    .foregroundColor(DS.Color.textSecondary)
            }
            Spacer()
        }
        .frame(height: 160)
    }
}
