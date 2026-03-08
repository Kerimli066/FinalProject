//
//  OnboardingTopBarBuilder.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//


import UIKit
import SnapKit

final class OnboardingTopBarBuilder {

    unowned let owner: OnboardingViewController

    init(owner: OnboardingViewController) {
        self.owner = owner
    }

    func build() {
        let sym = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)

        owner.backButton.setImage(
            UIImage(systemName: "chevron.left", withConfiguration: sym),
            for: .normal
        )
        owner.backButton.tintColor = AppTheme.Color.textPrimary
        owner.backButton.backgroundColor = AppTheme.Color.backgroundField
        owner.backButton.layer.cornerRadius = 18
        owner.backButton.alpha = 0

        owner.stepLabel.font = AppTheme.Font.bold(12)
        owner.stepLabel.textColor = AppTheme.Color.accent

        owner.skipButton.setTitle("Skip", for: .normal)
        owner.skipButton.setTitleColor(AppTheme.Color.textSecondary, for: .normal)
        owner.skipButton.titleLabel?.font = AppTheme.Font.semibold(14)

        let topBar = UIView()
        owner.view.addSubview(topBar)

        topBar.addSubview(owner.backButton)
        topBar.addSubview(owner.stepLabel)
        topBar.addSubview(owner.skipButton)

        topBar.snp.makeConstraints {
            $0.top.equalTo(owner.view.safeAreaLayoutGuide).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }

        owner.backButton.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }

        owner.stepLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        owner.skipButton.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
        }

        owner.backButton.addTarget(
            owner,
            action: #selector(OnboardingViewController.tappedBack),
            for: .touchUpInside
        )

        owner.skipButton.addTarget(
            owner,
            action: #selector(OnboardingViewController.tappedSkip),
            for: .touchUpInside
        )
    }
}