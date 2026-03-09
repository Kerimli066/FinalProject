//
//  AppTextField.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.03.26.
//

import UIKit

final class AppTextField: UIView {

    private let bg        = UIView()
    private let eyeButton = UIButton(type: .system)
    private var isSecure  = false

    let textField = UITextField()
    var text: String? { textField.text }

    init(placeholder: String,
         keyboard: UIKeyboardType = .default,
         secure: Bool = false) {
        super.init(frame: .zero)
        isSecure = secure

        bg.backgroundColor    = AppTheme.Color.backgroundField
        bg.layer.cornerRadius = AppTheme.Radius.medium
        bg.layer.borderWidth  = 1
        bg.layer.borderColor  = AppTheme.Color.stroke.cgColor
        addSubview(bg)
        bg.snp.makeConstraints { $0.edges.equalToSuperview() }

        textField.keyboardType           = keyboard
        textField.autocapitalizationType = .none
        textField.autocorrectionType     = .no
        textField.textColor              = AppTheme.Color.textPrimary
        textField.tintColor              = AppTheme.Color.accent
        textField.font                   = AppTheme.Font.semibold(15)
        textField.isSecureTextEntry      = secure
        textField.attributedPlaceholder  = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: AppTheme.Color.textMuted]
        )

        bg.addSubview(textField)
        textField.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview().inset(secure ? 48 : 16)
            $0.height.equalTo(54)
        }

        if secure {
            eyeButton.tintColor = AppTheme.Color.textMuted
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            eyeButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
            bg.addSubview(eyeButton)
            eyeButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.right.equalToSuperview().inset(12)
                $0.size.equalTo(30)
            }
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    @objc private func toggleVisibility() {
        isSecure = !isSecure
        textField.isSecureTextEntry = isSecure
        eyeButton.setImage(UIImage(systemName: isSecure ? "eye.slash" : "eye"), for: .normal)
    }
}
