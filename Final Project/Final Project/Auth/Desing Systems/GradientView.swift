//
//  GradientView.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import UIKit
import SnapKit
final class GradientView: UIView {

    private let gradientLayer = CAGradientLayer()

    init(top: UIColor    = AppTheme.Color.gradientTop,
         bottom: UIColor = AppTheme.Color.gradientBottom) {
        super.init(frame: .zero)
        gradientLayer.colors     = [top.cgColor, bottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.15, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 0.85, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
