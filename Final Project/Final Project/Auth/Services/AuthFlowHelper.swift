//
//  AuthFlowHelper.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import UIKit

enum AuthFlowHelper {

    @MainActor
    static func handlePostAuth(from vc: UIViewController, isNewUser: Bool) {
        if isNewUser {
            let popup = SuccessPopupViewController(
                title: "Welcome!",
                subtitle: "Your account is ready.\nLet's set up your server connection."
            )
            popup.onDismiss = { [weak vc] in
                guard let vc else { return }
                routeAfterSuccess(from: vc, isNewUser: true)
            }
            vc.present(popup, animated: true)
        } else {
            routeAfterSuccess(from: vc, isNewUser: false)
        }
    }

    @MainActor
    static func routeAfterSuccess(from vc: UIViewController, isNewUser: Bool) {
        let hasSeenNavMap = UserDefaults.standard.bool(forKey: AppFlags.hasSeenNavMap)

        if !ServerConfig.shared.isConfigured {
            let serverVC = ServerSetupViewController()
            serverVC.onComplete = { [weak vc] in
                guard let vc else { return }
                if isNewUser && !hasSeenNavMap {
                    UserDefaults.standard.set(true, forKey: AppFlags.hasSeenNavMap)
                    vc.navigationController?.pushViewController(NavMapViewController(), animated: true)
                } else {
                    guard let window = vc.view.window
                            ?? vc.navigationController?.view.window else { return }
                    AppRouter.setRoot(window: window)
                }
            }
            vc.navigationController?.pushViewController(serverVC, animated: true)
            return
        }

        if isNewUser && !hasSeenNavMap {
            UserDefaults.standard.set(true, forKey: AppFlags.hasSeenNavMap)
            vc.navigationController?.pushViewController(NavMapViewController(), animated: true)
            return
        }

        guard let window = vc.view.window
                ?? vc.navigationController?.view.window else { return }
        AppRouter.setRoot(window: window)
    }
}
