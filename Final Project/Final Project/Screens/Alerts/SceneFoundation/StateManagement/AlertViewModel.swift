//
//  AlertViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import SwiftUI

@MainActor
final class AlertViewModel: ObservableObject {

    @Published var alerts:         [Alert] = []
    @Published var filteredAlerts: [Alert] = []

    @Published var searchText: String = "" {
        didSet { applyFilter() }
    }

    @Published var selectedType: AlertFilterType = .all {
        didSet { applyFilter() }
    }

    @Published var isLoading:      Bool    = false
    @Published var errorMessage:   String? = nil
    @Published var showClearConfirm: Bool  = false

    private let service:      LumenService
    private var refreshTask:  Task<Void, Never>?
    private var didLoadOnce = false

    init(service: LumenService = AppEnvironment.makeLumenService()) {
        self.service = service
    }

    // MARK: - Lifecycle

    func onAppear() {
        if !didLoadOnce {
            didLoadOnce = true
            Task { await load(showLoading: true) }
        }

        guard refreshTask == nil else { return }
        startAutoRefresh()
    }

    func onDisappear() {
        refreshTask?.cancel()
        refreshTask = nil
    }

    // MARK: - Auto Refresh

    private func startAutoRefresh() {
        refreshTask?.cancel()
        refreshTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 4_000_000_000)
                guard !Task.isCancelled else { break }
                await self?.load(showLoading: false)
            }
        }
    }

    // MARK: - Load

    func load(showLoading: Bool = false) async {
        if showLoading { isLoading = true }

        do {
            let incoming = try await service.getAlertHistory()
                .sorted { $0.timestamp > $1.timestamp }
            alerts = incoming
            applyFilter()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    // MARK: - Clear

    func clearAll() async {
        do {
            try await service.clearAlertHistory()
            alerts        = []
            filteredAlerts = []
            errorMessage   = nil
            NotificationCenter.default.post(name: AlertEvents.historyCleared, object: nil)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Filter

    private func applyFilter() {
        var result = alerts

        switch selectedType {
        case .all:      break
        case .critical: result = result.filter { AlertSeverityCalculator.severity(for: $0) == .critical }
        case .high:     result = result.filter { AlertSeverityCalculator.severity(for: $0) == .high }
        case .medium:   result = result.filter { AlertSeverityCalculator.severity(for: $0) == .medium }
        }

        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !q.isEmpty {
            result = result.filter {
                $0.containerName.localizedCaseInsensitiveContains(q) ||
                $0.message.localizedCaseInsensitiveContains(q) ||
                $0.type.localizedCaseInsensitiveContains(q)
            }
        }

        filteredAlerts = result
    }

    // MARK: - Counts

    var criticalCount: Int {
        alerts.filter { AlertSeverityCalculator.severity(for: $0) == .critical }.count
    }

    var highCount: Int {
        alerts.filter { AlertSeverityCalculator.severity(for: $0) == .high }.count
    }

    var mediumCount: Int {
        alerts.filter { AlertSeverityCalculator.severity(for: $0) == .medium }.count
    }

    func count(for filter: AlertFilterType) -> Int? {
        switch filter {
        case .all:      return nil
        case .critical: return criticalCount
        case .high:     return highCount
        case .medium:   return mediumCount
        }
    }
}
