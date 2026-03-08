//
//  LogLevelBadge.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct LogLevelBadge: View {
    let level: LogLevel

    var body: some View {
        Group {
            if level == .all {
                Text("    ")
                    .font(.system(size: 9, weight: .black, design: .monospaced))
                    .frame(width: 36)
            } else {
                Text(level.tag)
                    .font(.system(size: 9, weight: .black, design: .monospaced))
                    .foregroundColor(level.color)
                    .tracking(0.5)
                    .frame(width: 36, alignment: .leading)
            }
        }
    }
}
