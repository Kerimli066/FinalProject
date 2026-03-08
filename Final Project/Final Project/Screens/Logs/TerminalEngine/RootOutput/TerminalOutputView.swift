//
//  TerminalOutputView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct TerminalOutputView: View {
    let lines: [LogLine]
    let autoScroll: Bool
    let isPaused: Bool

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(Array(lines.enumerated()), id: \.element.id) { idx, line in
                        TerminalLogLine(line: line, lineNumber: idx + 1)
                            .id(line.id)
                    }
                }
            }
            .background(DS.Color.bg0)
            .onChange(of: lines.count) { _, _ in
                guard autoScroll && !isPaused, let last = lines.last else { return }
                withAnimation(.easeOut(duration: 0.15)) {
                    proxy.scrollTo(last.id, anchor: .bottom)
                }
            }
        }
    }
}
