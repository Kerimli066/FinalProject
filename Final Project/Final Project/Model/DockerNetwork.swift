//
//  DockerNetwork.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//


import Foundation

struct DockerNetwork: Codable, Identifiable, Hashable {
    var id: String { Id }

    let Attachable: Bool?
    let Containers: [String: ContainerNetworkConfig]?
    let Created: String?
    let Driver: String?
    let EnableIPv6: Bool?
    let Id: String
    let Internal: Bool?
    let IPAM: Ipam?
    let Labels: [String: String]?
    let Name: String?
    let Options: [String: String]?
    let Scope: String?
}
extension DockerNetwork {
    var containerCount: Int { Containers?.count ?? 0 }
    var subnet: String { IPAM?.Config?.first?.Subnet ?? "N/A" }
}
