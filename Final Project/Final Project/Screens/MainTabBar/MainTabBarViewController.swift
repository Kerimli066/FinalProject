//
//  LogsView.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.02.26.
//

import UIKit
import SnapKit

final class MainTabBarController: UITabBarController {

    private var logsNav: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildTabs()
        styleTabBar()
    }

    func switchToAlerts() { selectedIndex = 3 }

    func switchToLogs(preselected: ContainerInfo) {
        selectedIndex = 2
        guard let nav = logsNav,
              let logsVC = nav.viewControllers.first as? LogsViewController else { return }
        Task { @MainActor in
            let service    = AppEnvironment.makeLumenService()
            let containers = (try? await service.listContainers()) ?? []
            logsVC.updatePreselected(preselected, containers: containers)
        }
    }

    // MARK: - Build
    private func buildTabs() {
        let logsNavVC = makeNav(
            root:  LogsViewController(),
            title: "Logs",
            icon:  "doc.text",
            tag:   2
        )
        logsNav = logsNavVC

        viewControllers = [
            makeNav(root: DashboardViewController(),  title: "Dashboard",  icon: "gauge.with.dots.needle.33percent", tag: 0),
            makeNav(root: ContainersViewController(), title: "Containers", icon: "square.stack.3d.up",               tag: 1),
            logsNavVC,
            makeNav(root: AlertViewController(),      title: "Alerts",     icon: "bell",                            tag: 3),
            makeNav(root: SettingsViewController(),   title: "Settings",   icon: "gearshape",                       tag: 4),
        ]
        selectedIndex = 0
    }

    // MARK: - Style
    private func styleTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = DS.UIColor.bg1

        let sel = DS.UIColor.accent
        let uns = DS.UIColor.textTertiary

        appearance.stackedLayoutAppearance.selected.iconColor           = sel
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: sel]
        appearance.stackedLayoutAppearance.normal.iconColor             = uns
        appearance.stackedLayoutAppearance.normal.titleTextAttributes   = [.foregroundColor: uns]

        tabBar.standardAppearance      = appearance
        tabBar.scrollEdgeAppearance    = appearance
        tabBar.tintColor               = sel
        tabBar.unselectedItemTintColor = uns
    }

    // MARK: - Helper
    private func makeNav(root: UIViewController, title: String, icon: String, tag: Int) -> UINavigationController {
        root.title      = title
        root.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), tag: tag)
        let nav = UINavigationController(rootViewController: root)
        nav.navigationBar.prefersLargeTitles = false
        return nav
    }
}


