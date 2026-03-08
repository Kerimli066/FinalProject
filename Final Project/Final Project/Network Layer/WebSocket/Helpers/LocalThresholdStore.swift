//
//  LocalThresholdStore.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.03.26.
//

import Foundation

enum LocalThresholdStore {

    private static let cpuKey = "pocketlumen.threshold.cpu.v1"

    static func loadCPU(default fallback: Double) -> Double {
        let v = UserDefaults.standard.double(forKey: cpuKey)
        return v == 0 ? fallback : v
    }

    static func saveCPU(_ value: Double) {
        UserDefaults.standard.set(value, forKey: cpuKey)
    }

    static func resetCPU() {
        UserDefaults.standard.removeObject(forKey: cpuKey)
    }
}
