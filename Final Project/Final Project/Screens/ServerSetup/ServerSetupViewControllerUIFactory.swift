//
//  ServerSetupViewControllerUIFactory.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//


import UIKit
import SnapKit

final class ServerSetupViewControllerUIFactory {

    unowned let owner: ServerSetupViewController

    init(owner: ServerSetupViewController) {
        self.owner = owner
    }

    func buildHeader() {
        let sym = UIImage.SymbolConfiguration(pointSize: 26, weight: .semibold)

        owner.iconImg.image       = UIImage(systemName: "server.rack", withConfiguration: sym)
        owner.iconImg.tintColor   = AppTheme.Color.accent
        owner.iconImg.contentMode = .scaleAspectFit

        owner.iconWrap.backgroundColor    = AppTheme.Color.accent.withAlphaComponent(0.13)
        owner.iconWrap.layer.cornerRadius = AppTheme.Radius.large
        owner.iconWrap.layer.borderWidth  = 1
        owner.iconWrap.layer.borderColor  = AppTheme.Color.accent.withAlphaComponent(0.30).cgColor
        AppTheme.Shadow.accent(on: owner.iconWrap.layer)

        owner.iconWrap.addSubview(owner.iconImg)
        owner.iconWrap.snp.makeConstraints {
            $0.size.equalTo(64)
        }

        owner.iconImg.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(28)
        }

        owner.titleLabel.text      = "Connect to Server"
        owner.titleLabel.font      = AppTheme.Font.bold(28)
        owner.titleLabel.textColor = AppTheme.Color.textPrimary

        owner.subLabel.text = "Enter your Pocket Lumen backend URL\nand test the connection before continuing."
        owner.subLabel.font = AppTheme.Font.regular(15)
        owner.subLabel.textColor = AppTheme.Color.textSecondary
        owner.subLabel.numberOfLines = 0

        owner.headerStack.axis      = .vertical
        owner.headerStack.spacing   = AppTheme.Spacing.xs
        owner.headerStack.alignment = .leading
        owner.headerStack.addArrangedSubview(owner.iconWrap)
        owner.headerStack.setCustomSpacing(AppTheme.Spacing.md, after: owner.iconWrap)
        owner.headerStack.addArrangedSubview(owner.titleLabel)
        owner.headerStack.addArrangedSubview(owner.subLabel)
    }

    func buildForm() {
        owner.fieldLabel.text      = "BACKEND URL"
        owner.fieldLabel.font      = AppTheme.Font.bold(11)
        owner.fieldLabel.textColor = AppTheme.Color.textSecondary

        owner.urlField.snp.makeConstraints {
            $0.height.equalTo(54)
        }

        owner.urlField.textField.autocapitalizationType = .none
        owner.urlField.textField.autocorrectionType     = .no
        owner.urlField.textField.keyboardType           = .URL
        owner.urlField.textField.font                   = AppTheme.Font.mono(14)
        owner.urlField.textField.delegate               = owner
        owner.urlField.textField.addTarget(
            owner,
            action: #selector(ServerSetupViewController.urlChanged),
            for: .editingChanged
        )

        owner.pingButton.snp.makeConstraints {
            $0.height.equalTo(52)
        }

        owner.pingButton.addTarget(
            owner,
            action: #selector(ServerSetupViewController.pingTapped),
            for: .touchUpInside
        )

        owner.pingSpinner.color = AppTheme.Color.accent
        owner.pingSpinner.hidesWhenStopped = true

        owner.pingStatus.text          = "⚠️  Test the connection first"
        owner.pingStatus.font          = AppTheme.Font.medium(13)
        owner.pingStatus.textColor     = AppTheme.Color.textMuted
        owner.pingStatus.numberOfLines = 0

        let pingRow = UIStackView(arrangedSubviews: [owner.pingSpinner, owner.pingStatus])
        pingRow.axis      = .horizontal
        pingRow.spacing   = AppTheme.Spacing.xs
        pingRow.alignment = .center

        owner.formStack.axis    = .vertical
        owner.formStack.spacing = AppTheme.Spacing.sm
        owner.formStack.addArrangedSubview(owner.fieldLabel)
        owner.formStack.addArrangedSubview(owner.urlField)
        owner.formStack.addArrangedSubview(owner.pingButton)
        owner.formStack.addArrangedSubview(pingRow)
    }

    func buildBottom() {
        owner.continueBtn.snp.makeConstraints {
            $0.height.equalTo(58)
        }

        owner.continueBtn.addTarget(
            owner,
            action: #selector(ServerSetupViewController.continueTapped),
            for: .touchUpInside
        )
        owner.continueBtn.isEnabled = false

        owner.skipLabel.text = "Skip — use demo server"
        owner.skipLabel.font = AppTheme.Font.regular(13)
        owner.skipLabel.textColor = AppTheme.Color.textMuted
        owner.skipLabel.textAlignment = .center
        owner.skipLabel.isUserInteractionEnabled = true
        owner.skipLabel.isHidden = !AppConfig.useMock

        owner.skipLabel.addGestureRecognizer(
            UITapGestureRecognizer(
                target: owner,
                action: #selector(ServerSetupViewController.skipTapped)
            )
        )

        owner.bottomStack.axis      = .vertical
        owner.bottomStack.spacing   = AppTheme.Spacing.md
        owner.bottomStack.alignment = .fill
        owner.bottomStack.addArrangedSubview(owner.continueBtn)
        owner.bottomStack.addArrangedSubview(owner.skipLabel)
    }
}