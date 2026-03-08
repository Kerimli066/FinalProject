//
//  BaseAuthViewController.swift
//  Final Project
//
//  Created by SabinaKarimli on 21.02.26.
//

import UIKit
import SwiftUI
import SnapKit

class BaseAuthViewController: UIViewController {

    let scrollView         = UIScrollView()
    let contentView        = UIView()
    private let bgGradient = GradientView()
    private var didRunEntrance = false

    var entranceViews: [UIView] { [] }

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.Color.backgroundPrimary

        view.insertSubview(bgGradient, at: 0)
        bgGradient.snp.makeConstraints { $0.edges.equalToSuperview() }

        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode          = .interactive
        scrollView.alwaysBounceVertical         = true
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        setupUI()
        setupConstraints()
        ScreenAnimator.prepareEntrance(entranceViews)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)

        if navigationController?.viewControllers.first !== self || navigationController == nil {
            addBackButton()
        }

        guard !didRunEntrance else { return }
        didRunEntrance = true
        ScreenAnimator.runEntrance(entranceViews)
    }

    func setupUI() {}
    func setupConstraints() {}

    private func addBackButton() {
        guard view.subviews.first(where: { $0.accessibilityIdentifier == "custom_back" }) == nil else { return }

        let sym = UIImage.SymbolConfiguration(pointSize: 14, weight: .bold)
        let btn = UIButton(type: .system)
        btn.accessibilityIdentifier = "custom_back"

        let iconName = navigationController != nil ? "chevron.left" : "xmark"
        btn.setImage(UIImage(systemName: iconName, withConfiguration: sym), for: .normal)
        btn.tintColor          = AppTheme.Color.textPrimary
        btn.backgroundColor    = AppTheme.Color.backgroundField
        btn.layer.cornerRadius = 18
        btn.layer.borderWidth  = 1
        btn.layer.borderColor  = AppTheme.Color.strokeLight.cgColor
        btn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)

        view.addSubview(btn)
        btn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.left.equalToSuperview().inset(20)
            $0.size.equalTo(36)
        }
    }

    @objc private func backTapped() {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
