//
//  DashChartGrid.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//



import SwiftUI

struct DashChartGrid: View {
    let minY: Double
    let maxY: Double
    let plot: DashChartPlotArea

    var body: some View {
        ForEach([0.0, 0.25, 0.5, 0.75, 1.0], id: \.self) { pct in
            let y = plot.tp + (1 - pct) * plot.cH
            let v = minY + pct * (maxY - minY)

            Path { p in
                p.move(to: CGPoint(x: plot.lp, y: y))
                p.addLine(to: CGPoint(x: plot.W, y: y))
            }
            .stroke(DS.Color.cardBorder, lineWidth: 1)

            Text(DashChartFormat.fmtY(v))
                .font(DS.Font.label(9))
                .foregroundColor(DS.Color.textTertiary)
                .frame(width: plot.lp - 6, alignment: .trailing)
                .position(x: (plot.lp - 6) / 2, y: y)
        }
    }
}

struct DashChartXAxisLabels: View {
    let timestamps: [Date]
    let plot: DashChartPlotArea

    var body: some View {
        let n = timestamps.count
        ForEach(DashChartFormat.xIndices(for: n), id: \.self) { i in
            let x = plot.lp + CGFloat(i) * plot.step
            Text(DashChartFormat.fmtTime(timestamps[i]))
                .font(DS.Font.label(9))
                .foregroundColor(DS.Color.textTertiary)
                .position(x: x, y: plot.H - plot.bp / 2 + 4)
        }
    }
}
