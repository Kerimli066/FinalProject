//
//  PrimaryButton.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.03.26.
//

import UIKit
final class PrimaryButton: UIButton {

    convenience init(title: String, color: UIColor = AppTheme.Color.accent) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = color
        AppTheme.Shadow.accent(on: layer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.white, for: .normal)
        titleLabel?.font    = AppTheme.Font.bold(16)
        layer.cornerRadius  = AppTheme.Radius.medium
        layer.masksToBounds = false
    }

    required init?(coder: NSCoder) { fatalError() }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha     = self.isHighlighted ? 0.82 : 1
                self.transform = self.isHighlighted
                    ? CGAffineTransform(scaleX: 0.985, y: 0.985) : .identity
            }
        }
    }
}
