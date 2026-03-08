//
//  LumenService.swift
//  Final Project
//
//  Created by SabinaKarimli on 13.02.26.
//


import Foundation

protocol LumenService {
    func listContainers() async throws -> [ContainerInfo]
    func getContainerDetail(id: String) async throws -> ContainerInfo

    func startContainer(id: String) async throws
    func stopContainer(id: String) async throws
    func restartContainer(id: String) async throws
    func removeContainer(id: String) async throws

    func listImages() async throws -> [DockerImage]
    func listNetworks() async throws -> [DockerNetwork]
    func listVolumes() async throws -> [DockerVolume]

    func getAlertHistory() async throws -> [Alert]
    func clearAlertHistory() async throws

    func getAlertSettings() async throws -> AlertSettings
    func updateAlertSettings(_ settings: AlertSettings) async throws
}
