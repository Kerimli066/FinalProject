import SwiftUI

enum DashboardAggregates {

    // MARK: - Normalize
    

    nonisolated static func normalizeToPercent(_ raw: Double) -> Double {
        max(0.0, min(100.0, raw))
    }

    // MARK: - Totals

    nonisolated static func computeTotals(
        latestStats: [String: ContainerStats]
    ) -> (cpu: Double, memMB: Double) {
        guard !latestStats.isEmpty else { return (0, 0) }
        let vals       = Array(latestStats.values)
        let totalCPU   = vals.reduce(0.0) { $0 + normalizeToPercent($1.cpuUsage) }
        let totalMemMB = vals.reduce(0.0) { $0 + Double($1.memoryUsage) / 1_048_576.0 }
        return (totalCPU, totalMemMB)
    }

    // MARK: - Top CPU

    nonisolated static func computeTopCPU(
        latestStats: [String: ContainerStats],
        containers: [ContainerInfo]
    ) -> (name: String, value: Double)? {
        guard let top = latestStats.max(by: {
            normalizeToPercent($0.value.cpuUsage) < normalizeToPercent($1.value.cpuUsage)
        }) else { return nil }
        let name  = containers.first { $0.id == top.key }?.name ?? top.key
        let value = normalizeToPercent(top.value.cpuUsage)
        return (name, value)
    }

    // MARK: - Top Memory

    nonisolated static func computeTopMemory(
        latestStats: [String: ContainerStats],
        containers: [ContainerInfo]
    ) -> (name: String, valueMB: Double)? {
        guard let top = latestStats.max(by: {
            $0.value.memoryUsage < $1.value.memoryUsage
        }) else { return nil }
        let name    = containers.first { $0.id == top.key }?.name ?? top.key
        let valueMB = Double(top.value.memoryUsage) / 1_048_576.0
        return (name, valueMB)
    }

    // MARK: - Critical Count

    nonisolated static func computeCriticalCount(
        latestStats: [String: ContainerStats],
        alertCriticalCount: Int
    ) -> Int {
        guard !latestStats.isEmpty else { return alertCriticalCount }
        let cpuTh = AlertSeverityHelper.Threshold.cpuHigh   // 20%
        let memTh = AlertSeverityHelper.Threshold.memHigh   // 80%
        return latestStats.values.filter { stat in
            let cpu = normalizeToPercent(stat.cpuUsage)
            let mem = stat.memoryPercent <= 1.0
                ? stat.memoryPercent * 100.0
                : stat.memoryPercent
            return cpu >= cpuTh || mem >= memTh
        }.count
    }
}


