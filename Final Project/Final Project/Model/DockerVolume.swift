//
//  DockerVolume.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//


import Foundation

struct DockerVolume: Codable, Identifiable, Hashable {
    var id: String { Name }

    let Driver: String
    let Labels: [String: String]?
    let Mountpoint: String
    let Name: String
    let Options: [String: String]?
}

extension DockerVolume {
    var sizeStr: String {
        return "—"
    }
}
