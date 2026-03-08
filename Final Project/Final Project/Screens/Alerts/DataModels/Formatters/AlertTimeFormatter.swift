//
//  AlertTimeFormatter.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import Foundation

struct AlertTimeFormatter {

    private static let timeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df
    }()

    private static let weekdayFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEE HH:mm"
        return df
    }()

    private static let longFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM d, HH:mm"
        return df
    }()

    static func relativeTime(_ date: Date) -> String {
        let diff = max(0, Date().timeIntervalSince(date))

        if diff < 60 { return "Just now" }
        if diff < 3600 { return "\(Int(diff / 60))m ago" }

        let cal = Calendar.current
        let timeStr = timeFormatter.string(from: date)

        if cal.isDateInToday(date) { return "Today \(timeStr)" }
        if cal.isDateInYesterday(date) { return "Yesterday \(timeStr)" }
        if diff < 7 * 86400 { return weekdayFormatter.string(from: date) }

        return longFormatter.string(from: date)
    }
}
