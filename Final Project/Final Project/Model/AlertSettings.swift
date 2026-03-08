//
//  AlertSettings.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//


import Foundation

struct AlertSettings: Codable, Equatable {
    let recipientEmail: String?
    let notificationsEnabled: Bool
}
