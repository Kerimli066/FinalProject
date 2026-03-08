//
//  TerminalLogLine.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct TerminalLogLine: View {
    let line: LogLine
    let lineNumber: Int

    @State private var flashed = false

    private var level: LogLevel { line.level }

    var body: some View {
        HStack(alignment: .top, spacing: 0) {

            LogLevelStrip(level: level)
                .frame(width: 2.5)

            HStack(alignment: .top, spacing: 0) {

                TerminalLineNumber(number: lineNumber)

                TerminalTimestamp(date: line.timestamp)

                LogLevelBadge(level: level)

                TerminalMessageText(text: line.line, level: level)
            }
            .padding(.vertical, 4.5)
        }
        .background(TerminalRowBackground(level: level, lineNumber: lineNumber))
        .overlay(LogFlashOverlay(level: level, flashed: flashed))
        .onAppear {
            guard !flashed else { return }
            withAnimation(.easeOut(duration: 0.5)) { flashed = true }
        }
    }
}
