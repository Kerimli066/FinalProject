//
//  Ipam.swift
//  Final Project
//
//  Created by SabinaKarimli on 06.03.26.
//


struct Ipam: Codable, Hashable {
    let Driver: String?
    let Config: [IpamConfig]?
    let Options: [String: String]?
}