//
//  ContainerStatsHistory.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import Foundation

struct ContainerStatsHistory {
    let containerId:   String
    var containerName: String
    var cpuPoints:     [DashChartPoint] = []
    var memoryPoints:  [DashChartPoint] = []
    var lastAppendedAt: Date? = nil

    private static let maxPoints = DashboardConstants.perContainerMaxPoints

    mutating func append(_ stats: ContainerStats) {
        let now    = Date()
        let cpuPct = max(0.0, min(stats.cpuUsage, 100.0))
        let memMB  = Double(stats.memoryUsage) / 1_048_576.0

        cpuPoints.append(DashChartPoint(timestamp: now, value: cpuPct))
        memoryPoints.append(DashChartPoint(timestamp: now, value: memMB))

        if cpuPoints.count    > Self.maxPoints { cpuPoints.removeFirst() }
        if memoryPoints.count > Self.maxPoints { memoryPoints.removeFirst() }

        lastAppendedAt = now
    }
}

