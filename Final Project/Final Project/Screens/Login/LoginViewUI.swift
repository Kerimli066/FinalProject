//
//  LoginViewUI.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//


import UIKit
import SnapKit

final class LoginViewUI {

    let iconWrap = UIView(), iconImg = UIImageView(), headerTitle = UILabel(), headerSub = UILabel()
    let headerStack = UIStackView(), emailLabel = UILabel(), passLabel = UILabel()
    let emailField = AppTextField(placeholder: "name@example.com", keyboard: .emailAddress)
    let passField = AppTextField(placeholder: "••••••••", secure: true), forgotBtn = UIButton(type: .system)
    let formStack = UIStackView(), signInBtn = PrimaryButton(title: "Sign In")
    let googleBtn = SocialAuthButton(provider: .googleAuth, style: .full)
    let githubBtn = SocialAuthButton(provider: .githubAuth, style: .full)
    let socialStack = UIStackView(), bottomInfo = UILabel(), bottomAction = UIButton(type: .system)
    let bottomRow = UIStackView(), emailErrorLabel = UILabel(), passErrorLabel = UILabel()

    func build(in contentView: UIView) {
        let sym = UIImage.SymbolConfiguration(pointSize: 26, weight: .semibold)
        iconImg.image = UIImage(systemName: "lock.shield.fill", withConfiguration: sym)
        iconImg.tintColor = .white
        iconImg.contentMode = .scaleAspectFit

        iconWrap.backgroundColor = AppTheme.Color.accentIndigo
        iconWrap.layer.cornerRadius = 18
        AppTheme.Shadow.accent(on: iconWrap.layer)
        iconWrap.addSubview(iconImg)

        headerTitle.text = "Welcome Back"
        headerTitle.font = AppTheme.Font.bold(34)
        headerTitle.textColor = AppTheme.Color.textPrimary
        headerTitle.textAlignment = .center

        headerSub.text = "Enter your credentials to access\nyour account securely."
        headerSub.font = AppTheme.Font.regular(15)
        headerSub.textColor = AppTheme.Color.textSecondary
        headerSub.numberOfLines = 2
        headerSub.textAlignment = .center

        headerStack.axis = .vertical
        headerStack.spacing = 10
        headerStack.alignment = .center
        [iconWrap, headerTitle, headerSub].forEach { headerStack.addArrangedSubview($0) }

        emailLabel.text = "EMAIL ADDRESS"
        emailLabel.font = AppTheme.Font.bold(11)
        emailLabel.textColor = AppTheme.Color.textSecondary

        passLabel.text = "PASSWORD"
        passLabel.font = AppTheme.Font.bold(11)
        passLabel.textColor = AppTheme.Color.textSecondary

        setupErrorLabel(emailErrorLabel)
        setupErrorLabel(passErrorLabel)

        forgotBtn.setTitle("Forgot Password?", for: .normal)
        forgotBtn.setTitleColor(AppTheme.Color.accent, for: .normal)
        forgotBtn.titleLabel?.font = AppTheme.Font.bold(13)
        forgotBtn.contentHorizontalAlignment = .right

        formStack.axis = .vertical
        formStack.spacing = 10
        [emailLabel, emailField, emailErrorLabel, passLabel, passField, passErrorLabel, forgotBtn]
            .forEach { formStack.addArrangedSubview($0) }
        formStack.setCustomSpacing(4, after: emailField)
        formStack.setCustomSpacing(14, after: emailErrorLabel)
        formStack.setCustomSpacing(4, after: passField)
        formStack.setCustomSpacing(8, after: passErrorLabel)

        socialStack.axis = .vertical
        socialStack.spacing = 12
        [makeDivider(), googleBtn, githubBtn].forEach { socialStack.addArrangedSubview($0) }

        bottomInfo.text = "Don't have an account?"
        bottomInfo.font = AppTheme.Font.semibold(13)
        bottomInfo.textColor = AppTheme.Color.textSecondary
        bottomAction.setTitle("Sign Up", for: .normal)
        bottomAction.setTitleColor(AppTheme.Color.accent, for: .normal)
        bottomAction.titleLabel?.font = AppTheme.Font.bold(13)

        bottomRow.axis = .horizontal
        bottomRow.spacing = 6
        bottomRow.alignment = .center
        [bottomInfo, bottomAction].forEach { bottomRow.addArrangedSubview($0) }

        [headerStack, formStack, signInBtn, socialStack, bottomRow].forEach { contentView.addSubview($0) }
    }

    func applyConstraints() {
        iconWrap.snp.makeConstraints { $0.size.equalTo(64) }
        iconImg.snp.makeConstraints { $0.center.equalToSuperview(); $0.size.equalTo(28) }
        emailField.snp.makeConstraints { $0.height.equalTo(54) }
        passField.snp.makeConstraints { $0.height.equalTo(54) }
        signInBtn.snp.makeConstraints { $0.height.equalTo(58) }
        googleBtn.snp.makeConstraints { $0.height.equalTo(56) }
        githubBtn.snp.makeConstraints { $0.height.equalTo(56) }

        headerStack.snp.makeConstraints { $0.top.equalToSuperview().inset(28); $0.left.right.equalToSuperview().inset(22) }
        formStack.snp.makeConstraints { $0.top.equalTo(headerStack.snp.bottom).offset(24); $0.left.right.equalToSuperview().inset(22) }
        signInBtn.snp.makeConstraints { $0.top.equalTo(formStack.snp.bottom).offset(16); $0.left.right.equalToSuperview().inset(22) }
        socialStack.snp.makeConstraints { $0.top.equalTo(signInBtn.snp.bottom).offset(20); $0.left.right.equalToSuperview().inset(22) }
        bottomRow.snp.makeConstraints { $0.top.equalTo(socialStack.snp.bottom).offset(20); $0.centerX.equalToSuperview(); $0.bottom.equalToSuperview().inset(16) }
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
        label.font = AppTheme.Font.bold(11)
        label.textColor = AppTheme.Color.textMuted
        left.backgroundColor = AppTheme.Color.stroke
        right.backgroundColor = AppTheme.Color.stroke
        [left, label, right].forEach { row.addSubview($0) }
        label.snp.makeConstraints { $0.center.equalToSuperview() }
        left.snp.makeConstraints { $0.left.centerY.equalToSuperview(); $0.right.equalTo(label.snp.left).offset(-12); $0.height.equalTo(1) }
        right.snp.makeConstraints { $0.right.centerY.equalToSuperview(); $0.left.equalTo(label.snp.right).offset(12); $0.height.equalTo(1) }
        row.snp.makeConstraints { $0.height.equalTo(20) }
        return row
    }
}