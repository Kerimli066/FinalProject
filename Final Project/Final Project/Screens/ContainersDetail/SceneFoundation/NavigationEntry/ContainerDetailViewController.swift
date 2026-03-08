//
//  ContainerDetailViewController.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import UIKit

final class ContainerDetailViewController: BaseViewController {

    private let container:         ContainerInfo
    private let onActionCompleted: (() -> Void)?
    private let onViewLogs:        ((ContainerInfo) -> Void)?

    override var prefersNavBarHidden: Bool { false }

    init(
        container:         ContainerInfo,
        onActionCompleted: (() -> Void)?              = nil,
        onViewLogs:        ((ContainerInfo) -> Void)? = nil
    ) {
        self.container         = container
        self.onActionCompleted = onActionCompleted
        self.onViewLogs        = onViewLogs
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = container.name
        setupUI()
    }

    override func setupUI() {
        embedSwiftUI(
            ContainerDetailView(
                container:         container,
                onRemoved:         { [weak self] in self?.popVC() },
                onActionCompleted: onActionCompleted,
                onViewLogs:        { [weak self] c in self?.onViewLogs?(c) }
            )
        )
    }
}
