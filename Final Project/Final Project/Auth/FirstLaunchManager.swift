//
//  FirstLaunchManager.swift
//  Final Project
//
//  Created by SabinaKarimli on 06.02.26.
//


import Foundation

enum FirstLaunchManager {
    private static let key = "app.hasLaunchedBefore"

    static var isFirstLaunchAfterInstall: Bool {
        if UserDefaults.standard.bool(forKey: key) == false {
            UserDefaults.standard.set(true, forKey: key)
            return true
        }
        return false
    }
}
