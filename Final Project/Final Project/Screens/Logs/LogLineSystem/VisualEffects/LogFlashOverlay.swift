//
//  LogFlashOverlay.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct LogFlashOverlay: View {
    let level: LogLevel
    let flashed: Bool

    var body: some View {
        Rectangle()
            .fill(level.color.opacity(flashed ? 0 : 0.04))
            .allowsHitTesting(false)
    }
}
