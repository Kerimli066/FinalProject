//
//  AutoChoiceViewController.swift
//  Final Project
//
//  Created by SabinaKarimli on 21.02.26.
//

import UIKit
import SnapKit

final class AutoChoiceViewController: UIViewController {

    private let vm             = AutoChoiceViewModel()
    private var hasAnimated    = false

    private let gradient       = GradientView()
    private let glowView       = UIView()
    private let logoView       = UIImageView()
    private let titleLabel     = UILabel()
    private let subtitleLabel  = UILabel()
    private let signInButton   = UIButton(type: .system)
    private let createCard     = UIButton(type: .system)
    private let newUserLabel   = UILabel()
    private let createLabel    = UILabel()
    private let arrowIcon      = UIImageView()
    private let termsLabel     = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.Color.backgroundPrimary
        buildUI()
        setupActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !hasAnimated else { return }
        hasAnimated = true
        runEntrance()
    }

    private func buildUI() {
        view.insertSubview(gradient, at: 0)
        gradient.snp.makeConstraints { $0.edges.equalToSuperview() }

        glowView.backgroundColor   = AppTheme.Color.accentGlow
        glowView.layer.cornerRadius = 90
        glowView.layer.shadowColor  = AppTheme.Color.accent.cgColor
        glowView.layer.shadowOpacity = 0.85
        glowView.layer.shadowRadius  = 90
        glowView.layer.shadowOffset  = .zero

        logoView.image       = UIImage(named: "authLogo")
        logoView.contentMode = .scaleAspectFit

        titleLabel.text          = "Monitor Everywhere"
        titleLabel.font          = AppTheme.Font.heavy(34)
        titleLabel.textColor     = AppTheme.Color.textPrimary
        titleLabel.textAlignment = .center

        subtitleLabel.text          = "Access your dashboards and live\nalerts anywhere in the world."
        subtitleLabel.font          = AppTheme.Font.regular(17)
        subtitleLabel.textColor     = AppTheme.Color.textSecondary
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center

        var cfg = UIButton.Configuration.filled()
        cfg.title                = "Sign In"
        cfg.baseBackgroundColor  = AppTheme.Color.accent
        cfg.cornerStyle          = .large
        cfg.attributedTitle      = AttributedString("Sign In", attributes: AttributeContainer([
            .font: AppTheme.Font.bold(18),
            .foregroundColor: UIColor.white
        ]))
        signInButton.configuration = cfg
        signInButton.layer.shadowColor   = AppTheme.Color.accent.cgColor
        signInButton.layer.shadowOpacity = 0.55
        signInButton.layer.shadowRadius  = 22
        signInButton.layer.shadowOffset  = CGSize(width: 0, height: 12)

        createCard.backgroundColor    = UIColor.white.withAlphaComponent(0.05)
        createCard.layer.cornerRadius = AppTheme.Radius.large
        createCard.layer.borderWidth  = 1
        createCard.layer.borderColor  = AppTheme.Color.strokeLight.cgColor

        newUserLabel.text      = "New user?"
        newUserLabel.font      = AppTheme.Font.regular(13)
        newUserLabel.textColor = AppTheme.Color.textSecondary
        newUserLabel.isUserInteractionEnabled = false

        createLabel.text      = "Create an Account"
        createLabel.font      = AppTheme.Font.semibold(17)
        createLabel.textColor = AppTheme.Color.textPrimary
        createLabel.isUserInteractionEnabled = false

        let sym = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        arrowIcon.image               = UIImage(systemName: "person.badge.plus", withConfiguration: sym)
        arrowIcon.tintColor           = AppTheme.Color.textSecondary
        arrowIcon.contentMode         = .scaleAspectFit
        arrowIcon.isUserInteractionEnabled = false

        termsLabel.text          = "By continuing, you agree to our Terms of Service\nand Privacy Policy."
        termsLabel.font          = AppTheme.Font.regular(12)
        termsLabel.textColor     = UIColor.white.withAlphaComponent(0.22)
        termsLabel.numberOfLines = 2
        termsLabel.textAlignment = .center

        [glowView, titleLabel, subtitleLabel, signInButton, createCard, termsLabel].forEach {
            view.addSubview($0)
            $0.alpha = 0
        }
        glowView.addSubview(logoView)
        createCard.addSubview(newUserLabel)
        createCard.addSubview(createLabel)
        createCard.addSubview(arrowIcon)

        glowView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(56)
            $0.size.equalTo(180)
        }
        logoView.snp.makeConstraints { $0.center.equalToSuperview(); $0.size.equalTo(110) }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(glowView.snp.bottom).offset(46)
            $0.left.right.equalToSuperview().inset(28)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(40)
        }
        signInButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(60)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(64)
        }
        createCard.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(16)
            $0.left.right.equalTo(signInButton)
            $0.height.equalTo(88)
        }
        newUserLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(22)
        }
        createLabel.snp.makeConstraints {
            $0.top.equalTo(newUserLabel.snp.bottom).offset(4)
            $0.left.equalTo(newUserLabel)
        }
        arrowIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(22)
            $0.size.equalTo(32)
        }
        termsLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.left.right.equalToSuperview().inset(36)
        }
    }

    private func setupActions() {
        signInButton.addTarget(self, action: #selector(tappedSignIn), for: .touchUpInside)
        createCard.addTarget(self, action: #selector(tappedCreate), for: .touchUpInside)

        vm.navigateToLogin = { [weak self] in
            self?.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        vm.navigateToRegister = { [weak self] in
            self?.navigationController?.pushViewController(RegisterViewController(), animated: true)
        }
    }

    @objc private func tappedSignIn() { vm.signInTapped() }
    @objc private func tappedCreate() { vm.createAccountTapped() }

    private func runEntrance() {
        let items: [UIView] = [glowView, titleLabel, subtitleLabel, signInButton, createCard, termsLabel]
        items.forEach { $0.transform = CGAffineTransform(translationX: 0, y: 36) }

        for (i, item) in items.enumerated() {
            UIView.animate(
                withDuration: 0.75,
                delay: Double(i) * 0.10 + 0.05,
                usingSpringWithDamping: 0.78,
                initialSpringVelocity: 0.4,
                options: .allowUserInteraction
            ) {
                item.alpha     = 1
                item.transform = .identity
            }
        }

        UIView.animate(
            withDuration: 2.2, delay: 1.2,
            options: [.repeat, .autoreverse, .allowUserInteraction]
        ) {
            self.glowView.transform = CGAffineTransform(scaleX: 1.06, y: 1.06)
            self.glowView.alpha     = 0.78
        }
    }
}

