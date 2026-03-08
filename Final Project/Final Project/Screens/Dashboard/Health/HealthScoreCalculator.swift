import Foundation

enum HealthScoreCalculator {

    static func calculateTarget(
        latestStats: [String: ContainerStats],
        allContainers: [ContainerInfo],
        criticalAlertCount: Int,
        previousScore: Int
    ) -> Int {
        guard !latestStats.isEmpty else { return 100 }

            var penalty = 0

            let cpuValues = latestStats.values.map {
                DashboardAggregates.normalizeToPercent($0.cpuUsage)
            }
            let maxCPU  = cpuValues.max() ?? 0
            let totalCPU = cpuValues.reduce(0, +)

            if maxCPU >= 80       { penalty += 45 }
            else if maxCPU >= 50  { penalty += 30 }
            else if maxCPU >= 20  { penalty += 15 }
            else if maxCPU >= 12  { penalty += 6  }

            if totalCPU >= 100    { penalty += 25 }
            else if totalCPU >= 60 { penalty += 15 }
            else if totalCPU >= 40 { penalty += 8  }
            else if totalCPU >= 20 { penalty += 3  }

            let memValues = latestStats.values.map { s -> Double in
                guard s.memoryLimit > 0 else {
                    return s.memoryPercent <= 1.0 ? s.memoryPercent * 100 : s.memoryPercent
                }
                return Double(s.memoryUsage) / Double(s.memoryLimit) * 100.0
            }
            let avgMem = memValues.isEmpty ? 0 : memValues.reduce(0,+) / Double(memValues.count)

            if avgMem >= AlertSeverityHelper.Threshold.memHigh        { penalty += 20 }
            else if avgMem >= AlertSeverityHelper.Threshold.memMedium { penalty += 10 }
            else if avgMem >= 40                                       { penalty += 4  }

            penalty += min(criticalAlertCount * 8, 30)

            let stoppedCount = allContainers.filter {
                $0.state.lowercased() != "running"
            }.count
            penalty += min(stoppedCount * 4, 16)

            return max(0, min(100, 100 - penalty))
    }

    static func calculate(
        latestStats: [String: ContainerStats],
        allContainers: [ContainerInfo],
        criticalAlertCount: Int
    ) -> Int {
        calculateTarget(
            latestStats: latestStats,
            allContainers: allContainers,
            criticalAlertCount: criticalAlertCount,
            previousScore: 100
        )
    }
}
