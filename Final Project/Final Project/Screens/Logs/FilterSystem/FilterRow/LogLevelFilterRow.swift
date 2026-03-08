//
//  LogLevelFilterRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct LogLevelFilterRow: View {
    @Binding var selectedLevel: LogLevel
    let countForLevel: (LogLevel) -> Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 7) {
                ForEach(LogLevel.allCases, id: \.self) { level in
                    LogLevelChip(
                        level: level,
                        selectedLevel: $selectedLevel,
                        count: countForLevel(level)
                    )
                }
            }
            .padding(.horizontal, 1)
        }
    }
}
