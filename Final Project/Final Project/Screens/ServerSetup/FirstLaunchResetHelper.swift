//
//  FirstLaunchResetHelper.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//



import Foundation

enum FirstLaunchResetHelper {

    private static let key = "pocketlumen.hasLaunchedBefore.v1"

    static func resetIfNeeded() {
        let hasLaunched = UserDefaults.standard.bool(forKey: key)
        guard !hasLaunched else { return }

        ServerConfig.shared.reset()

        UserDefaults.standard.set(true, forKey: key)
    }
}
