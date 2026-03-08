//
//  LogsViewController.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import UIKit

final class LogsViewController: BaseViewController {

    override var prefersNavBarHidden: Bool { true }
    private let logsState = LogsState()

    override func setupUI() {
        embedSwiftUI(LogsView(state: logsState))
    }

    func updatePreselected(_ container: ContainerInfo, containers: [ContainerInfo]) {
        logsState.preselected = container
        logsState.containers  = containers
    }
}

