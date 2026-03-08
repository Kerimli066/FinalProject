//
//  MultiTooltipOverlay.swift
//  Final Project
//
//  Created by SabinaKarimli on 06.03.26.
//

import SwiftUI

struct MultiTooltipOverlay: View {
    let idx: Int
    let series: [(name: String, color: Color, points: [DashChartPoint])]
    let metrics: ChartMetrics
    let plot: DashChartPlotArea

    private var x: CGFloat { plot.lp + CGFloat(idx) * plot.step }

    private var entries: [(name: String, color: Color, value: Double)] {
        series.compactMap { s -> (String, Color, Double)? in
            guard idx < s.points.count else { return nil }
            return (s.name, s.color, s.points[idx].value)
        }
        .sorted { $0.2 > $1.2 }
        .prefix(5)
        .map { $0 }
    }

    private var timeStr: String {
        guard let first = series.first, idx < first.points.count else { return "" }
        return DashChartFormat.fmtTime(first.points[idx].timestamp)
    }

    var body: some View {
        ZStack {
            Path { p in
                p.move(to: CGPoint(x: x, y: plot.tp))
                p.addLine(to: CGPoint(x: x, y: plot.tp + plot.cH))
            }
            .stroke(Color.white.opacity(0.2), style: StrokeStyle(lineWidth: 1, dash: [4, 3]))

            VStack(alignment: .leading, spacing: 3) {
                Text(timeStr)
                    .font(DS.Font.label(10))
                    .foregroundColor(DS.Color.textTertiary)

                ForEach(entries.indices, id: \.self) { i in
                    let e = entries[i]
                    HStack(spacing: 4) {
                        Circle().fill(e.color).frame(width: 5, height: 5)
                        Text("\(e.name): \(String(format: "%.1f%%", e.value))")
                            .font(DS.Font.caption(11))
                            .foregroundColor(e.color)
                    }
                }
            }
            .padding(.horizontal, 9)
            .padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: 9)
                    .fill(DS.Color.bg4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 9)
                            .stroke(DS.Color.bg5, lineWidth: 1)
                    )
            )
            .shadow(color: .black.opacity(0.55), radius: 12)
            .position(
                x: min(max(x, 90), plot.W - 90),
                y: plot.tp + plot.cH / 3
            )
        }
    }
}
