//
//  MockLumenService.swift
//  Final Project
//
//  Created by SabinaKarimli on 12.02.26.
//

import Foundation

final class MockLumenService: LumenService {

    // MARK: - Singleton
    static let shared = MockLumenService()
    private init() { startAlertSimulation() }

    // MARK: - Store
    private var containersStore: [ContainerInfo] = MockData.containers
    private var alertsStore:     [Alert]         = MockData.alerts()
    private var settingsStore:   AlertSettings   = MockData.defaultAlertSettings
    private var alertSimTask:    Task<Void, Never>?

    // MARK: - Containers

    func listContainers() async throws -> [ContainerInfo] {
        try? await Task.sleep(nanoseconds: 400_000_000)
        return containersStore
    }

    func getContainerDetail(id: String) async throws -> ContainerInfo {
        try? await Task.sleep(nanoseconds: 200_000_000)
        guard let c = containersStore.first(where: { $0.id == id }) else {
            throw URLError(.badServerResponse)
        }
        return c
    }

    func startContainer(id: String) async throws {
        try? await Task.sleep(nanoseconds: 300_000_000)
        guard let i = containersStore.firstIndex(where: { $0.id == id }) else { return }
        let c = containersStore[i]
        containersStore[i] = ContainerInfo(
            id: c.id, name: c.name,
            status: "Up 1 second",
            image: c.image, state: "running",
            created: c.created,
            env: c.env, ports: c.ports, mounts: c.mounts
        )
    }

    func stopContainer(id: String) async throws {
        try? await Task.sleep(nanoseconds: 300_000_000)
        guard let i = containersStore.firstIndex(where: { $0.id == id }) else { return }
        let c = containersStore[i]
        containersStore[i] = ContainerInfo(
            id: c.id, name: c.name,
            status: "Exited (0) 1 second ago",
            image: c.image, state: "exited",
            created: c.created,
            env: c.env, ports: c.ports, mounts: c.mounts
        )
    }

    func restartContainer(id: String) async throws {
        try await stopContainer(id: id)
        try? await Task.sleep(nanoseconds: 200_000_000)
        try await startContainer(id: id)
    }

    func removeContainer(id: String) async throws {
        try? await Task.sleep(nanoseconds: 300_000_000)
        containersStore.removeAll { $0.id == id }
    }

    // MARK: - Resources

    func listImages() async throws -> [DockerImage] {
        try? await Task.sleep(nanoseconds: 300_000_000)
        return MockData.images
    }

    func listVolumes() async throws -> [DockerVolume] {
        try? await Task.sleep(nanoseconds: 300_000_000)
        return MockData.volumes
    }

    func listNetworks() async throws -> [DockerNetwork] {
        try? await Task.sleep(nanoseconds: 300_000_000)
        return MockData.networks
    }

    // MARK: - Alerts

    func getAlertHistory() async throws -> [Alert] {
        try? await Task.sleep(nanoseconds: 200_000_000)
        return alertsStore
    }

    func clearAlertHistory() async throws {
        try? await Task.sleep(nanoseconds: 200_000_000)
        alertsStore.removeAll()
    }

    func getAlertSettings() async throws -> AlertSettings {
        try? await Task.sleep(nanoseconds: 100_000_000)
        return settingsStore
    }

    func updateAlertSettings(_ settings: AlertSettings) async throws {
        try? await Task.sleep(nanoseconds: 100_000_000)
        settingsStore = settings
    }

    // MARK: - Alert Simulation

    private func startAlertSimulation() {
        alertSimTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 4_000_000_000)
                guard !Task.isCancelled else { break }
                self?.addSimulatedAlert()
            }
        }
    }

    private func addSimulatedAlert() {
        let candidates: [(id: String, name: String)] = [
            ("e517a71599f8befac1924000180debd05e9c5bacd3a3a2d4c86d53ba28c86d50", "log-cpu-heavy"),
            ("a039244dfa47c1fae56d0c7242f955031e13a084f97ef37915e7e056f240d760", "lumen-app"),
            ("6f17dc43969e870f612f8c37cf5150162440a4c6eb998b773b4142ad8f7ad48e", "log-mongodb"),
            ("8365e424b7bf114c7b96f6f638846a139a013086b5728ab576504e0f8e909879", "log-memory-heavy"),
            ("ed1d3a36a3a3b854d6b2536196565dd9a670b9a007353685940b1c236c26b48c", "lumen-postgres"),
        ]

        let types = ["CPU", "MEMORY"]
        let container = candidates.randomElement()!
        let type_     = types.randomElement()!

        let value: Double
        if type_ == "CPU" {
            let r = Double.random(in: 0...1)
            if r < 0.15 {
                value = Double.random(in: 20.0...28.0)
            } else if r < 0.35 {
                value = Double.random(in: 12.0...19.9)
            } else {
                value = Double.random(in: 1.0...11.9)
            }
        } else {
            let r = Double.random(in: 0...1)
            if r < 0.15 {
                value = Double.random(in: 80.0...95.0)
            } else if r < 0.35 {
                value = Double.random(in: 60.0...79.9)
            } else {
                value = Double.random(in: 10.0...59.9)
            }
        }

        let severityLabel: String
        if type_ == "CPU" {
            if value >= 20.0 { severityLabel = "Critical" }
            else if value >= 12.0 { severityLabel = "High" }
            else { severityLabel = "Elevated" }
        } else {
            if value >= 80.0 { severityLabel = "Critical" }
            else if value >= 60.0 { severityLabel = "High" }
            else { severityLabel = "Elevated" }
        }

        let alert = Alert(
            id:            UUID().uuidString,
            containerId:   container.id,
            containerName: container.name,
            type:          type_,
            message:       "\(severityLabel) \(type_) usage: \(String(format: "%.1f", value))%",
            value:         value,
            timestamp:     Date()
        )

        alertsStore.insert(alert, at: 0)
        if alertsStore.count > 50 {
            alertsStore = Array(alertsStore.prefix(50))
        }
    }
}
