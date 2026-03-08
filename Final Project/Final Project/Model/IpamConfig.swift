//
//  IpamConfig.swift
//  Final Project
//
//  Created by SabinaKarimli on 06.03.26.
//


struct IpamConfig: Codable, Hashable {
    let Subnet: String?
    let Gateway: String?
    let IPRange: String?
    let NetworkID: String?
}