//
//  DashboardViewController.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import UIKit
import SwiftUI
import SnapKit

final class DashboardViewController: BaseViewController {

    override var prefersNavBarHidden: Bool { true }

    
    override func setupUI() {
        let dashView = DashboardView(
            onViewAllAlerts: { [weak self] in
                guard let tabBar = self?.tabBarController as? MainTabBarController else { return }
                tabBar.switchToAlerts()
            }
        )
        embedSwiftUI(dashView)
    }
}
