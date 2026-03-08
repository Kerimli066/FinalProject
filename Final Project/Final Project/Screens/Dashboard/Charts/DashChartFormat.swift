//
//  DashChartFormat.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI


struct DashChartFormat {
    static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()

    static func fmtY(_ v: Double) -> String {
        v >= 1000 ? String(format: "%.0fk", v / 1000) : String(format: "%.0f", v)
    }

    static func fmtTime(_ d: Date) -> String {
        timeFormatter.string(from: d)
    }

    static func xIndices(for count: Int) -> [Int] {
        guard count > 0 else { return [] }
        let s = max(1, count / 6)
        return stride(from: 0, to: count, by: s).map { $0 }
    }
}



