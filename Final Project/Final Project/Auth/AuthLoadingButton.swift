//
//  AuthLoadingButton.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import UIKit
import SnapKit
final class AuthLoadingButton: UIButton {

    private let spinner    = UIActivityIndicatorView(style: .medium)
    private var savedTitle: String?

    override init(frame: CGRect) { super.init(frame: frame); setup() }
    required init?(coder: NSCoder) { super.init(coder: coder); setup() }

    private func setup() {
        spinner.hidesWhenStopped = true
        spinner.color            = .white
        addSubview(spinner)
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func setLoading(_ loading: Bool) {
        if loading {
            isEnabled  = false
            savedTitle = title(for: .normal)
            setTitle("", for: .normal)
            spinner.startAnimating()
            alpha = 0.85
        } else {
            isEnabled = true
            setTitle(savedTitle, for: .normal)
            spinner.stopAnimating()
            alpha = 1.0
        }
    }
}
