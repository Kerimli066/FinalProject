//
//  DashboardChartBuilder.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

enum DashboardChartBuilder {

    static func makeGlobalCPUPoints(from history: [GlobalStatPoint]) -> [DashChartPoint] {
        history.map { DashChartPoint(timestamp: $0.timestamp, value: $0.totalCPU) }
    }

    static func makeGlobalMemoryPoints(from history: [GlobalStatPoint]) -> [DashChartPoint] {
        history.map { DashChartPoint(timestamp: $0.timestamp, value: $0.totalMemoryMB) }
    }

    static func makeCPUContributionSeries(from perContainerHistory: [String: ContainerStatsHistory]) -> [(name: String, color: Color, points: [DashChartPoint])] {
        let palette: [Color] = [
            DS.Color.accent,
            DS.Color.success,
            DS.Color.warning,
            DS.Color.danger,
            DS.Color.alertHigh,
            DS.Color.alertMedium,
            DS.Color.alertLow,
            DS.Color.textSecondary,
            DS.Color.chartPalette[0],
            DS.Color.chartPalette[1],
            DS.Color.chartPalette[2],
            DS.Color.chartPalette[3],
            DS.Color.chartPalette[4],
            DS.Color.chartPalette[5]
        ]

        let sorted = perContainerHistory.values.sorted { $0.containerName < $1.containerName }
        let items: [(name: String, color: Color, points: [DashChartPoint])] = sorted.enumerated().map { i, h in
            let idx = i % max(palette.count, 1)
            return (name: h.containerName, color: palette[idx], points: h.cpuPoints)
        }

        return items
    }
}

