//
//  DashMultiLineChart.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct DashMultiLineChart: View {

    let series:   [(name: String, color: Color, points: [DashChartPoint])]
    let title:    String
    let subtitle: String

    @State private var hoveredIdx: Int?

    private var chartMetrics: ChartMetrics {
        ChartMetrics(series: series)
    }

    var body: some View {
        DashChartCard(title: title, subtitle: subtitle) {
            let metrics = chartMetrics

            if metrics.maxLen < 2 {
                DashChartEmptyState()
            } else {
                chartCanvas(metrics: metrics)
            }

            if metrics.maxLen >= 2, !series.isEmpty {
                legendView
            }
        }
    }

    private func chartCanvas(metrics: ChartMetrics) -> some View {
        let xTimestamps: [Date]? = {
            guard let first = series.first, first.points.count == metrics.maxLen else { return nil }
            return first.points.map(\.timestamp)
        }()

        return DashInteractiveChartCanvas(
            count: metrics.maxLen,
            minY: metrics.minY,
            maxY: metrics.maxY,
            height: 200,
            showXAxisFromTimestamps: xTimestamps,
            hoveredIdx: $hoveredIdx
        ) { [series] plot in
            ZStack(alignment: .topLeading) {
                ForEach(0..<series.count, id: \.self) { si in
                    let s = series[si]
                    if s.points.count > 1 {
                        SeriesLayer(series: s, metrics: metrics, plot: plot)
                    }
                }

                if let idx = hoveredIdx {
                    MultiTooltipOverlay(idx: idx, series: series, metrics: metrics, plot: plot)
                }
            }
        }
    }

    private var legendView: some View {
        LazyVGrid(
            columns: [GridItem(.flexible()), GridItem(.flexible())],
            spacing: 8
        ) {
            ForEach(series.indices, id: \.self) { i in
                let s = series[i]
                LegendItem(name: s.name, color: s.color, lastValue: s.points.last?.value)
            }
        }
        .padding(.top, 12)
    }
}










