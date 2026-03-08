//
//  RelativeTime.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import Foundation

enum RelativeTime {
    static func abbrev(unixSeconds: Int64?) -> String {
        guard let c = unixSeconds else { return "—" }
        let f = RelativeDateTimeFormatter()
        f.unitsStyle = .abbreviated
        return f.localizedString(
            for: Date(timeIntervalSince1970: TimeInterval(c)),
            relativeTo: Date()
        )
    }
}