//
//  ContainerStats.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//


import Foundation

struct ContainerStats: Codable, Hashable {
    let containerId: String
    let cpuUsage: Double
    let memoryUsage: Int64
    let memoryLimit: Int64
    let memoryPercent: Double
    let networkRx: Int64
    let networkTx: Int64
}
