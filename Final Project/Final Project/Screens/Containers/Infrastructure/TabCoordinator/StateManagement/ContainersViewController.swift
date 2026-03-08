//
//  ContainersViewController.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import UIKit
import SwiftUI

final class ContainersViewController: BaseViewController {

    override var prefersNavBarHidden: Bool { true }

    override func setupUI() {
        embedSwiftUI(
            ContainersTabView(
                onSelectContainer: { [weak self] container in
                    self?.openDetail(for: container)
                }
            ),
            in: view
        )
    }

    private func openDetail(for container: ContainerInfo) {
        let vc = ContainerDetailViewController(
            container: container,
            onActionCompleted: {
                NotificationCenter.default.post(
                    name: Notification.Name("containersNeedsRefresh"),
                    object: nil
                )
            },
            onViewLogs: { [weak self] c in
                (self?.tabBarController as? MainTabBarController)?.switchToLogs(preselected: c)
            }
        )
        pushVC(vc)
    }
}
