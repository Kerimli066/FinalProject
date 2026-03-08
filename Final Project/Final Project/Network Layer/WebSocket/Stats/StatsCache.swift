//
//  StatsCache.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import Foundation

final class StatsCache {
    static let shared = StatsCache()
    private init() {}

    private let defaults = UserDefaults.standard
    private let prefix = "pocketlumen.stats.cache."

    func save(stats: ContainerStats, containerIdKey: String) {
        let env = CachedStatsEnvelope(stats: stats, cachedAt: Date())
        guard let data = try? JSONEncoder().encode(env) else { return }
        defaults.set(data, forKey: prefix + containerIdKey)
    }

    func save(stats: ContainerStats) {
        save(stats: stats, containerIdKey: stats.containerId)
    }

    func load(containerId: String) -> CachedStatsEnvelope? {
        guard let data = defaults.data(forKey: prefix + containerId),
              let env = try? JSONDecoder().decode(CachedStatsEnvelope.self, from: data)
        else { return nil }
        return env
    }

    func clear(containerId: String) {
        defaults.removeObject(forKey: prefix + containerId)
    }
}
