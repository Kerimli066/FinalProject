//
//  DashboardViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI
import FirebaseAuth
import Combine

@MainActor
final class DashboardViewModel: ObservableObject {

    // MARK: - Published State

    @Published private(set) var containers: [ContainerInfo] = []
    @Published private(set) var recentAlerts: [Alert] = []
    @Published private(set) var latestStats: [String: ContainerStats] = [:]
    @Published private(set) var globalHistory: [GlobalStatPoint] = []
    @Published private(set) var perContainerHistory: [String: ContainerStatsHistory] = [:]

    @Published private(set) var totalCPU: Double = 0
    @Published private(set) var totalMemoryMB: Double = 0
    @Published private(set) var runningCount: Int = 0
    @Published private(set) var criticalCount: Int = 0
    @Published private(set) var healthScore: Int = 100

    @Published private(set) var topCPUContainer: (name: String, value: Double)?
    @Published private(set) var topMemoryContainer: (name: String, valueMB: Double)?

    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isRefreshing: Bool = false
    @Published private(set) var errorMessage: String?
    @Published var selectedChartTab: ChartTab = .cpuContribution

    // MARK: - Chart Tab

    enum ChartTab: String, CaseIterable {
        case cpuContribution = "CPU Contribution"
        case cpuTrend        = "CPU Trend"
        case memoryTrend     = "Memory Trend"
    }

    // MARK: - Private

    private let service: LumenService
    private let statsStreaming: StatsStreaming
    private let coordinator: DashboardCoordinator

    private var alertCriticalCount: Int = 0
    private var clearObserverToken: NSObjectProtocol?
    private var recalcTimer: Task<Void, Never>?

    // MARK: - Init

    init(
        service: LumenService = AppEnvironment.makeLumenService(),
        statsStreaming: StatsStreaming = AppEnvironment.makeStatsStreaming()
    ) {
        self.service = service
        self.statsStreaming = statsStreaming
        self.coordinator = DashboardCoordinator(service: service, statsStreaming: statsStreaming)
        bindCoordinator()
        bindClearNotification()
    }

    deinit {
        if let token = clearObserverToken {
            NotificationCenter.default.removeObserver(token)
        }
    }

    // MARK: - Lifecycle

    private var didStartOnce = false

    func onAppear() {
        guard !didStartOnce else { return }
        didStartOnce = true
        isLoading = true
        isRefreshing = true
        errorMessage = nil
        coordinator.startInitialLoad()
        startRecalcTimer()
    }

    func onDisappear() {
        coordinator.stopAll()
        recalcTimer?.cancel()
        recalcTimer = nil
        didStartOnce = false
    }

    func refresh() {
        coordinator.stopAll()
        recalcTimer?.cancel()
        recalcTimer = nil
        resetState()
        didStartOnce = false
        isLoading = true
        isRefreshing = true
        errorMessage = nil
        coordinator.startInitialLoad()
        startRecalcTimer()
        didStartOnce = true
    }


    private func startRecalcTimer() {
        recalcTimer?.cancel()
        recalcTimer = Task { [weak self] in
            while !Task.isCancelled {
                do {
                    try await Task.sleep(nanoseconds: UInt64(DashboardConstants.recalcInterval * 1_000_000_000))
                } catch { break }
                guard let self, !Task.isCancelled else { break }
                self.recalculateAggregates()
            }
        }
    }

    // MARK: - Coordinator Binding

    private func bindCoordinator() {
        coordinator.onContainersFetched = { [weak self] fetched in
            guard let self else { return }
            self.containers = fetched
            self.runningCount = fetched.filter { $0.isRunning }.count
            for c in fetched {
                if self.perContainerHistory[c.id] != nil {
                    self.perContainerHistory[c.id]?.containerName = c.name
                }
            }
            self.isLoading = false
            self.isRefreshing = false
            self.recalculateAggregates()
        }

        coordinator.onAlertsFetched = { [weak self] alerts in
            guard let self else { return }
            self.applyAlerts(alerts)
            self.isLoading = false
            self.isRefreshing = false
        }

        coordinator.onStatsReceived = { [weak self] stats, containerId in
            guard let self else { return }
            self.handleStats(stats, containerId: containerId)
        }

        coordinator.onSnapshotTick = { [weak self] in
            guard let self else { return }
            self.takeGlobalSnapshot()
        }

        coordinator.onError = { [weak self] msg in
            guard let self else { return }
            self.errorMessage = msg
            self.isLoading = false
            self.isRefreshing = false
        }
    }

    private func bindClearNotification() {
        clearObserverToken = NotificationCenter.default.addObserver(
            forName: AlertEvents.historyCleared,
            object: nil,
            queue: nil
        ) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.handleAlertHistoryCleared()
            }
        }
    }

    // MARK: - Data Handlers

    private func applyAlerts(_ alerts: [Alert]) {
        let sorted = alerts.sorted { $0.timestamp > $1.timestamp }
        recentAlerts = Array(sorted.prefix(5))
        alertCriticalCount = alerts.filter {
            AlertSeverityHelper.isCritical(type: $0.type, value: $0.value)
        }.count
        criticalCount = alertCriticalCount
        recalculateAggregates()
    }

    private func handleStats(_ stats: ContainerStats, containerId: String) {
        latestStats[containerId] = stats

        if perContainerHistory[containerId] == nil {
            let name = containers.first(where: { $0.id == containerId })?.name ?? containerId
            perContainerHistory[containerId] = ContainerStatsHistory(
                containerId: containerId,
                containerName: name
            )
        }

        let now = Date()
        if let last = perContainerHistory[containerId]?.lastAppendedAt,
           now.timeIntervalSince(last) < DashboardConstants.historyAppendInterval {
           
        } else {
            perContainerHistory[containerId]?.append(stats)
        }
    }

    private func takeGlobalSnapshot() {
        guard !latestStats.isEmpty else { return }
        globalHistory.append(GlobalStatPoint(
            timestamp: Date(),
            totalCPU: totalCPU,
            totalMemoryMB: totalMemoryMB
        ))
        if globalHistory.count > DashboardConstants.maxGlobalPoints {
            globalHistory.removeFirst()
        }
    }

    private func handleAlertHistoryCleared() {
        recentAlerts = []
        alertCriticalCount = 0
        if latestStats.isEmpty { criticalCount = 0 }
        recalculateAggregates()
    }

    // MARK: - Recalculate

    private func recalculateAggregates() {
        if latestStats.isEmpty {
            totalCPU = 0
            totalMemoryMB = 0
            criticalCount = 0
            return
        }

        let totals = DashboardAggregates.computeTotals(latestStats: latestStats)
        totalCPU = totals.cpu
        totalMemoryMB = totals.memMB

        topCPUContainer = DashboardAggregates.computeTopCPU(
            latestStats: latestStats, containers: containers
        )
        topMemoryContainer = DashboardAggregates.computeTopMemory(
            latestStats: latestStats, containers: containers
        )
        criticalCount = DashboardAggregates.computeCriticalCount(
            latestStats: latestStats, alertCriticalCount: alertCriticalCount
        )

        let targetScore = HealthScoreCalculator.calculateTarget(
            latestStats: latestStats,
            allContainers: containers,
            criticalAlertCount: criticalCount,
            previousScore: healthScore
        )
        let alpha = 0.3
        let smoothed = Int((Double(targetScore) * alpha + Double(healthScore) * (1.0 - alpha)).rounded())
        healthScore = max(0, min(100, smoothed))
    }

    // MARK: - Reset

    private func resetState() {
        latestStats.removeAll()
        globalHistory.removeAll()
        perContainerHistory.removeAll()
        recentAlerts = []
        containers = []
        totalCPU = 0
        totalMemoryMB = 0
        runningCount = 0
        criticalCount = 0
        alertCriticalCount = 0
        topCPUContainer = nil
        topMemoryContainer = nil
        healthScore = 100
        errorMessage = nil
    }

    // MARK: - Computed

    var healthStatus: HealthStatus { HealthStatus.from(score: healthScore) }
    var isCalculatingHealth: Bool { latestStats.isEmpty && runningCount > 0 }

    var cpuSparkline: [Double] { globalHistory.suffix(20).map(\.totalCPU) }
    var memSparkline: [Double] { globalHistory.suffix(20).map(\.totalMemoryMB) }

    var globalCPUPoints: [DashChartPoint] {
        DashboardChartBuilder.makeGlobalCPUPoints(from: globalHistory)
    }
    var globalMemoryPoints: [DashChartPoint] {
        DashboardChartBuilder.makeGlobalMemoryPoints(from: globalHistory)
    }
    var cpuContributionSeries: [(name: String, color: Color, points: [DashChartPoint])] {
        DashboardChartBuilder.makeCPUContributionSeries(from: perContainerHistory)
    }
}

