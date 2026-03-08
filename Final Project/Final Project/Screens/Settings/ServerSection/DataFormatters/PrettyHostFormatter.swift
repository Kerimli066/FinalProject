//
//  PrettyHostFormatter.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import Foundation

enum PrettyHostFormatter {
    static func prettyHost(from baseURL: String) -> String {
        if let url = URL(string: baseURL), let host = url.host {
            return url.port.map { "\(host):\($0)" } ?? host
        }
        return baseURL
            .replacingOccurrences(of: "http://", with: "")
            .replacingOccurrences(of: "https://", with: "")
            .trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    }
}