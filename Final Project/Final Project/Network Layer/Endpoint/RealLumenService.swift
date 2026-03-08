//
//  RealLumenService.swift
//  Final Project
//
//  Created by SabinaKarimli on 13.02.26.
//

import Foundation
final class RealLumenService: LumenService {

    private let client: NetworkClient
    private let base: String

    init(baseURL: String = AppConfig.baseURL, client: NetworkClient = .init()) {
        self.base = baseURL
        self.client = client
    }

    func listContainers() async throws -> [ContainerInfo] {
        try await client.send(PocketLumenEndpoint.listContainers(base: base))
    }

    func getContainerDetail(id: String) async throws -> ContainerInfo {
        try await client.send(PocketLumenEndpoint.containerDetail(base: base, id: id))
    }

    func startContainer(id: String) async throws {
        _ = try await client.send(PocketLumenEndpoint.startContainer(base: base, id: id), as: EmptyResponse.self)
    }

    func stopContainer(id: String) async throws {
        _ = try await client.send(PocketLumenEndpoint.stopContainer(base: base, id: id), as: EmptyResponse.self)
    }

    func restartContainer(id: String) async throws {
        _ = try await client.send(PocketLumenEndpoint.restartContainer(base: base, id: id), as: EmptyResponse.self)
    }

    func removeContainer(id: String) async throws {
        _ = try await client.send(PocketLumenEndpoint.removeContainer(base: base, id: id), as: EmptyResponse.self)
    }

    func listImages() async throws -> [DockerImage] {
        try await client.send(PocketLumenEndpoint.listImages(base: base))
    }

    func listNetworks() async throws -> [DockerNetwork] {
        try await client.send(PocketLumenEndpoint.listNetworks(base: base))
    }

    func listVolumes() async throws -> [DockerVolume] {
        try await client.send(PocketLumenEndpoint.listVolumes(base: base))
    }

    func getAlertHistory() async throws -> [Alert] {
        try await client.send(PocketLumenEndpoint.alertHistory(base: base))
    }

    func clearAlertHistory() async throws {
        _ = try await client.send(PocketLumenEndpoint.clearAlertHistory(base: base), as: EmptyResponse.self)
    }

    func getAlertSettings() async throws -> AlertSettings {
        try await client.send(PocketLumenEndpoint.getAlertSettings(base: base))
    }

    func updateAlertSettings(_ settings: AlertSettings) async throws {
        _ = try await client.send(
            PocketLumenEndpoint.updateAlertSettings(base: base, body: settings),
            as: EmptyResponse.self
        )
    }
}
