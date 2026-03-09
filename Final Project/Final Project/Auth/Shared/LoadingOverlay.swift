//
//  LoadingOverlay.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//


import UIKit
import SnapKit

final class LoadingOverlay: UIView {

    private let blur    = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    private let spinner = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        alpha = 0

        addSubview(blur)
        blur.snp.makeConstraints { $0.edges.equalToSuperview() }

        spinner.color = AppTheme.Color.textPrimary
        addSubview(spinner)
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
        spinner.startAnimating()
    }

    required init?(coder: NSCoder) { fatalError() }

    func show(in view: UIView) {
        if superview == nil {
            view.addSubview(self)
            snp.makeConstraints { $0.edges.equalToSuperview() }
        }
        ScreenAnimator.fadeIn(self)
    }

    func hide() {
        ScreenAnimator.fadeOut(self) { self.removeFromSuperview() }
    }
}
