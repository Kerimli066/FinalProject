//
//  SeriesLayer.swift
//  Final Project
//
//  Created by SabinaKarimli on 06.03.26.
//


import SwiftUI

struct SeriesLayer: View {
    let series: (name: String, color: Color, points: [DashChartPoint])
    let metrics: ChartMetrics
    let plot: DashChartPlotArea

    private func cgPoints() -> [CGPoint] {
        let n = series.points.count
        guard n > 0 else { return [] }
        let step = n > 1 ? plot.cW / CGFloat(n - 1) : plot.cW
        return series.points.enumerated().map { i, p in
            CGPoint(
                x: plot.lp + CGFloat(i) * step,
                y: metrics.yPos(value: p.value, plot: plot)
            )
        }
    }

    var body: some View {
        let pts = cgPoints()
        guard pts.count > 1,
              let first = pts.first,
              let last = pts.last
        else { return AnyView(EmptyView()) }

        let fillPath = Path { p in
            p.move(to: CGPoint(x: first.x, y: plot.tp + plot.cH))
            p.addLine(to: first)
            pts.dropFirst().forEach { p.addLine(to: $0) }
            p.addLine(to: CGPoint(x: last.x, y: plot.tp + plot.cH))
            p.closeSubpath()
        }

        let linePath = Path { p in
            for (i, pt) in pts.enumerated() {
                i == 0 ? p.move(to: pt) : p.addLine(to: pt)
            }
        }

        return AnyView(
            ZStack {
                fillPath
                    .fill(LinearGradient(
                        colors: [series.color.opacity(0.12), .clear],
                        startPoint: .top, endPoint: .bottom
                    ))
                linePath
                    .stroke(
                        series.color,
                        style: StrokeStyle(lineWidth: 1.8, lineCap: .round, lineJoin: .round)
                    )
                    .shadow(color: series.color.opacity(0.35), radius: 4)
            }
        )
    }
}
