//
//  ContainerNetworkConfig.swift
//  Final Project
//
//  Created by SabinaKarimli on 06.03.26.
//


struct ContainerNetworkConfig: Codable, Hashable {
    let Name: String?
    let EndpointID: String?
    let MacAddress: String?
    let IPv4Address: String?
    let IPv6Address: String?
}