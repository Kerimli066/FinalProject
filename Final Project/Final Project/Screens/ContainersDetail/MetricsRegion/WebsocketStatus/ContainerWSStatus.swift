//
//  ContainerWSStatus.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

enum ContainerWSStatus {
    @MainActor static func text(for statsVM: StatsStreamViewModel) -> String {
        if statsVM.isOfflineFallback {
            return statsVM.cachedAtText.map { "Cached \($0)" } ?? "Offline"
        }

        switch statsVM.connectionState {
        case .idle:                 return "Idle"
        case .connecting:           return "Connecting"
        case .connected:            return "Live"
        case .disconnected(let r):  return r.isEmpty ? "Disconnected" : r
        case .failed(let e):        return e.isEmpty ? "Error" : e
        }
    }

    @MainActor static func color(for statsVM: StatsStreamViewModel) -> Color {
        if statsVM.isOfflineFallback { return DS.Color.warning }

        switch statsVM.connectionState {
        case .connected:    return DS.Color.success
        case .connecting:   return DS.Color.accent
        case .idle:         return DS.Color.textTertiary
        case .disconnected: return DS.Color.warning
        case .failed:       return DS.Color.danger
        }
    }

    @MainActor static func isConnected(_ statsVM: StatsStreamViewModel) -> Bool {
        if case .connected = statsVM.connectionState { return true }
        return false
    }
}
