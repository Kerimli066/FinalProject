//
//  CachedStatsEnvelope.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import Foundation


struct CachedStatsEnvelope: Codable {
    let stats: ContainerStats
    let cachedAt: Date
}
