//
//  BaseViewController.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import UIKit
import SwiftUI
import SnapKit

class BaseViewController: UIViewController {

    private let bgGradient = GradientView()
    let contentView = UIView()

    private var loadingOverlay: LoadingOverlay?

    var prefersNavBarHidden: Bool { true }

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.Color.backgroundPrimary

        view.insertSubview(bgGradient, at: 0)
        bgGradient.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        setupUI()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(prefersNavBarHidden, animated: false)
    }

    func setupUI() {}
    func setupConstraints() {}

    @discardableResult
    func embedSwiftUI<V: View>(_ swiftUIView: V) -> UIHostingController<V> {
        let hosting = UIHostingController(rootView: swiftUIView)
        hosting.view.backgroundColor = .clear

        if #available(iOS 16.0, *) {
            hosting.sizingOptions = .preferredContentSize
        }

        addChild(hosting)
        view.addSubview(hosting.view)

        hosting.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        hosting.didMove(toParent: self)
        return hosting
    }

    @discardableResult
    func embedSwiftUI<V: View>(_ swiftUIView: V, in container: UIView) -> UIHostingController<V> {
        let hosting = UIHostingController(rootView: swiftUIView)
        hosting.view.backgroundColor = .clear

        if #available(iOS 16.0, *) {
            hosting.sizingOptions = .preferredContentSize
        }

        addChild(hosting)
        container.addSubview(hosting.view)

        hosting.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        hosting.didMove(toParent: self)
        return hosting
    }

    func pushVC(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }

    func popVC(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    func switchTab(_ index: Int) {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        tabBar.selectedIndex = index
    }

    func showAlert(title: String, message: String? = nil, action: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default))
        present(alert, animated: true)
    }

    func showLoading() {
        guard loadingOverlay == nil else { return }

        let overlay = LoadingOverlay()
        overlay.show(in: view)
        loadingOverlay = overlay
    }

    func hideLoading() {
        loadingOverlay?.hide()
        loadingOverlay = nil
    }
}
