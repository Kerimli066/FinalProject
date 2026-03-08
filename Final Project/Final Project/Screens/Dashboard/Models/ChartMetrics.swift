//
//  ChartMetrics.swift
//  Final Project
//
//  Created by SabinaKarimli on 06.03.26.
//

import SwiftUI

struct ChartMetrics {
    let minY: Double
    let maxY: Double
    let maxLen: Int

    init(series: [(name: String, color: Color, points: [DashChartPoint])]) {
        var lo = Double.infinity
        var hi = -Double.infinity
        var len = 0
        for s in series {
            for p in s.points {
                if p.value < lo { lo = p.value }
                if p.value > hi { hi = p.value }
            }
            if s.points.count > len { len = s.points.count }
        }
        self.minY   = lo == .infinity ? 0 : lo
        self.maxY   = max(hi == -.infinity ? 100 : hi, 10)
        self.maxLen = len
    }

    func yPos(value: Double, plot: DashChartPlotArea) -> CGFloat {
        let range = max(maxY - minY, 1.0)
        return plot.tp + CGFloat(1.0 - (value - minY) / range) * plot.cH
    }
}
