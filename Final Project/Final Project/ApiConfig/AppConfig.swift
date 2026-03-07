//
//  AppConfig.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.02.26.
//

import Foundation

enum AppConfig {
    static var baseURL: String { ServerConfig.shared.baseURL }
    static let useMock = true
}
