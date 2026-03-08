//
//  TerminalTimestamp.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct TerminalTimestamp: View {
    let date: Date

    private static let timeFmt: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm:ss.SSS"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()

    private var timeStr: String { Self.timeFmt.string(from: date) }

    var body: some View {
        Text(timeStr)
            .font(.system(size: 9, weight: .regular, design: .monospaced))
            .foregroundColor(DS.Color.textTertiary.opacity(0.45))
            .frame(width: 76, alignment: .leading)
    }
}
