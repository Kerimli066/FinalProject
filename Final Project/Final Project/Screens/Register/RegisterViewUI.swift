//
//  RegisterViewUI.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//


import UIKit
import SnapKit

final class RegisterViewUI {

    let titleLabel = UILabel(), subtitleLabel = UILabel(), headerStack = UIStackView()
    let emailLabel = UILabel(), passLabel = UILabel()
    let emailField = AppTextField(placeholder: "name@example.com", keyboard: .emailAddress)
    let passField = AppTextField(placeholder: "Min. 8 characters", secure: true)
    let formStack = UIStackView(), createBtn = PrimaryButton(title: "Create Account")
    let googleBtn = SocialAuthButton(provider: .googleAuth, style: .full)
    let githubBtn = SocialAuthButton(provider: .githubAuth, style: .full)
    let socialStack = UIStackView(), bottomRow = UIStackView()
    let emailErrorLabel = UILabel(), passErrorLabel = UILabel()

    func build(in contentView: UIView, target: RegisterViewController) {
        titleLabel.text = "Create Account"
        titleLabel.font = AppTheme.Font.bold(28)
        titleLabel.textColor = AppTheme.Color.textPrimary

        subtitleLabel.text = "Start monitoring your infrastructure today."
        subtitleLabel.font = AppTheme.Font.regular(15)
        subtitleLabel.textColor = AppTheme.Color.textSecondary
        subtitleLabel.numberOfLines = 2

        headerStack.axis = .vertical
        headerStack.spacing = 6
        headerStack.alignment = .leading
        [titleLabel, subtitleLabel].forEach { headerStack.addArrangedSubview($0) }

        emailLabel.text = "Email Address"
        emailLabel.font = AppTheme.Font.bold(11)
        emailLabel.textColor = AppTheme.Color.textSecondary

        passLabel.text = "Password"
        passLabel.font = AppTheme.Font.bold(11)
        passLabel.textColor = AppTheme.Color.textSecondary

        setupErrorLabel(emailErrorLabel)
        setupErrorLabel(passErrorLabel)

        emailField.snp.makeConstraints { $0.height.equalTo(54) }
        passField.snp.makeConstraints { $0.height.equalTo(54) }
        createBtn.snp.makeConstraints { $0.height.equalTo(58) }
        googleBtn.snp.makeConstraints { $0.height.equalTo(54) }
        githubBtn.snp.makeConstraints { $0.height.equalTo(54) }

        formStack.axis = .vertical
        formStack.spacing = 10
        [emailLabel, emailField, emailErrorLabel, passLabel, passField, passErrorLabel]
            .forEach { formStack.addArrangedSubview($0) }
        formStack.setCustomSpacing(4, after: emailField)
        formStack.setCustomSpacing(14, after: emailErrorLabel)
        formStack.setCustomSpacing(4, after: passField)

        socialStack.axis = .vertical
        socialStack.spacing = 10
        [makeDivider(), googleBtn, githubBtn].forEach { socialStack.addArrangedSubview($0) }

        let bottomInfo = UILabel()
        bottomInfo.text = "Already have an account?"
        bottomInfo.font = AppTheme.Font.regular(13)
        bottomInfo.textColor = AppTheme.Color.textSecondary
        let bottomAction = UIButton(type: .system)
        bottomAction.setTitle("Sign In", for: .normal)
        bottomAction.setTitleColor(AppTheme.Color.accent, for: .normal)
        bottomAction.titleLabel?.font = AppTheme.Font.bold(13)
        bottomAction.addTarget(target, action: #selector(target.tappedLogin), for: .touchUpInside)

        bottomRow.axis = .horizontal
        bottomRow.spacing = 4
        bottomRow.alignment = .center
        [bottomInfo, bottomAction].forEach { bottomRow.addArrangedSubview($0) }

        [headerStack, formStack, createBtn, socialStack, bottomRow].forEach { contentView.addSubview($0) }
        applyConstraints()
    }

    private func applyConstraints() {
        headerStack.snp.makeConstraints { $0.top.equalToSuperview().inset(80); $0.left.right.equalToSuperview().inset(24) }
        formStack.snp.makeConstraints { $0.top.equalTo(headerStack.snp.bottom).offset(32); $0.left.right.equalToSuperview().inset(24) }
        createBtn.snp.makeConstraints { $0.top.equalTo(formStack.snp.bottom).offset(28); $0.left.right.equalToSuperview().inset(24) }
        socialStack.snp.makeConstraints { $0.top.equalTo(createBtn.snp.bottom).offset(24); $0.left.right.equalToSuperview().inset(24) }
        bottomRow.snp.makeConstraints { $0.top.equalTo(socialStack.snp.bottom).offset(28); $0.centerX.equalToSuperview(); $0.bottom.equalToSuperview().inset(32) }
    }

    private func setupErrorLabel(_ label: UILabel) {
        label.font = AppTheme.Font.medium(12)
        label.textColor = AppTheme.Color.error
        label.numberOfLines = 0
        label.alpha = 0
        label.isHidden = true
    }

    private func makeDivider() -> UIView {
        let row = UIView(), label = UILabel(), left = UIView(), right = UIView()
        label.text = "OR CONTINUE WITH"
        label.font = AppTheme.Font.bold(10)
        label.textColor = AppTheme.Color.textMuted
        left.backgroundColor = AppTheme.Color.stroke
        right.backgroundColor = AppTheme.Color.stroke
        [left, label, right].forEach { row.addSubview($0) }
        label.snp.makeConstraints { $0.center.equalToSuperview() }
        left.snp.makeConstraints { $0.left.centerY.equalToSuperview(); $0.right.equalTo(label.snp.left).offset(-10); $0.height.equalTo(1) }
        right.snp.makeConstraints { $0.right.centerY.equalToSuperview(); $0.left.equalTo(label.snp.right).offset(10); $0.height.equalTo(1) }
        row.snp.makeConstraints { $0.height.equalTo(20) }
        return row
    }
}