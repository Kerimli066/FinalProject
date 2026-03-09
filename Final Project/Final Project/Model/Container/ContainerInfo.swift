//
//  ContainerInfo.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//


import Foundation
import SwiftUI

struct ContainerInfo: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let status: String
    let image: String
    let state: String
    let created: Int64

    let env: [String: String]?
    let ports: [String]?
    let mounts: [String]?
}


extension ContainerInfo {
    var isRunning: Bool {
        state.lowercased() == "running"
    }
}


extension ContainerInfo {
    var isSystemCritical: Bool { name.lowercased() == "lumen-app" }
}


extension ContainerInfo {
    var displayStatus: String {
        let lower = status.lowercased()
        if lower == "running" { return "Up (running)" }
        if lower == "exited"  { return "Exited" }
        if lower == "paused"  { return "Paused" }
        return status
    }
}
