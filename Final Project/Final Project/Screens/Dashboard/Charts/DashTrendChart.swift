//
//  DashTrendChart.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct DashTrendChart: View {
    let points:   [DashChartPoint]
    let color:    Color
    let title:    String
    let subtitle: String

    @State private var hoveredIdx: Int? = nil

    private var minY: Double { points.map(\.value).min() ?? 0 }
    private var maxY: Double { max((points.map(\.value).max() ?? 100), 10) }

    var body: some View {
        DashChartCard(title: title, subtitle: subtitle) {
            if points.count < 2 {
                DashChartEmptyState()
            } else {
                chartCanvas
            }
        }
    }

    private var chartCanvas: some View {
        let ts = points.map(\.timestamp)

        return DashInteractiveChartCanvas(
            count: points.count,
            minY: minY,
            maxY: maxY,
            height: 190,
            showXAxisFromTimestamps: ts,
            hoveredIdx: $hoveredIdx
        ) { plot in
            ZStack(alignment: .topLeading) {
                Path { p in
                    let pts = chartPoints(step: plot.step, lp: plot.lp, tp: plot.tp, cH: plot.cH)
                    guard let f = pts.first else { return }
                    p.move(to: CGPoint(x: f.x, y: plot.tp + plot.cH))
                    p.addLine(to: f)
                    pts.dropFirst().forEach { p.addLine(to: $0) }
                    p.addLine(to: CGPoint(x: pts.last!.x, y: plot.tp + plot.cH))
                    p.closeSubpath()
                }
                .fill(LinearGradient(
                    colors: [color.opacity(0.3), color.opacity(0)],
                    startPoint: .top, endPoint: .bottom
                ))

                Path { p in
                    let pts = chartPoints(step: plot.step, lp: plot.lp, tp: plot.tp, cH: plot.cH)
                    for (i, pt) in pts.enumerated() { i == 0 ? p.move(to: pt) : p.addLine(to: pt) }
                }
                .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .shadow(color: color.opacity(0.5), radius: 6)

                if let idx = hoveredIdx {
                    tooltip(idx: idx, plot: plot)
                }
            }
        }
    }

    private func chartPoints(step: CGFloat, lp: CGFloat, tp: CGFloat, cH: CGFloat) -> [CGPoint] {
        points.enumerated().map { i, pt in
            CGPoint(
                x: lp + CGFloat(i) * step,
                y: tp + (1 - (pt.value - minY) / max(maxY - minY, 1)) * cH
            )
        }
    }

    private func tooltip(idx: Int, plot: DashChartPlotArea) -> some View {
        let pt = points[idx]
        let x  = plot.lp + CGFloat(idx) * plot.step
        let y  = plot.tp + (1 - (pt.value - minY) / max(maxY - minY, 1)) * plot.cH

        let box = VStack(alignment: .leading, spacing: 2) {
            Text(DashChartFormat.fmtTime(pt.timestamp))
                .font(DS.Font.label(10))
                .foregroundColor(DS.Color.textTertiary)

            Text(String(format: "%.2f", pt.value))
                .font(DS.Font.caption(11))
                .foregroundColor(color)
        }
        .padding(.horizontal, 9)
        .padding(.vertical, 7)
        .background(
            RoundedRectangle(cornerRadius: 9)
                .fill(DS.Color.bg4)
                .overlay(
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(color.opacity(0.35), lineWidth: 1)
                )
        )
        .shadow(color: .black.opacity(0.5), radius: 10)
        .position(x: min(max(x, 80), plot.W - 80), y: max(y - 42, 28))

        return ZStack {
            Path { p in
                p.move(to: CGPoint(x: x, y: plot.tp))
                p.addLine(to: CGPoint(x: x, y: plot.tp + plot.cH))
            }
            .stroke(color.opacity(0.4), style: StrokeStyle(lineWidth: 1, dash: [4, 3]))

            Circle()
                .fill(color)
                .frame(width: 9, height: 9)
                .shadow(color: color.opacity(0.7), radius: 5)
                .position(x: x, y: y)

            box
        }
    }
}
