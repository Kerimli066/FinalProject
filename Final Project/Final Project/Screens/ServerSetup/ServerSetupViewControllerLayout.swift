//
//  ServerSetupViewControllerLayout.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//


import UIKit
import SnapKit

final class ServerSetupViewControllerLayout {

    unowned let owner: ServerSetupViewController

    init(owner: ServerSetupViewController) {
        self.owner = owner
    }

    func setupConstraints() {
        owner.contentView.addSubview(owner.headerStack)
        owner.contentView.addSubview(owner.formStack)

        owner.headerStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.left.right.equalToSuperview().inset(AppTheme.Spacing.lg)
        }

        owner.formStack.snp.makeConstraints {
            $0.top.equalTo(owner.headerStack.snp.bottom).offset(AppTheme.Spacing.xl)
            $0.left.right.equalToSuperview().inset(AppTheme.Spacing.lg)
            $0.bottom.equalToSuperview().inset(160)
        }

        owner.view.addSubview(owner.bottomStack)
        owner.bottomStack.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(AppTheme.Spacing.lg)
            $0.bottom.equalTo(owner.view.safeAreaLayoutGuide).inset(AppTheme.Spacing.lg)
        }
    }
}