//
//  SuccessPopupViewController.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import UIKit
import SnapKit


final class SuccessPopupViewController: UIViewController {

    var onDismiss: (() -> Void)?

    private let titleText:    String
    private let subtitleText: String

    private let card       = UIView()
    private let checkWrap  = UIView()
    private let checkImg   = UIImageView()
    private let titleLabel = UILabel()
    private let subLabel   = UILabel()
    private let okButton   = UIButton(type: .system)

    init(title: String = "Success!", subtitle: String = "Welcome! Account created.") {
        self.titleText    = title
        self.subtitleText = subtitle
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle   = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        ScreenAnimator.popIn(card)
    }

    private func buildUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        card.backgroundColor    = AppTheme.Color.backgroundCard
        card.layer.cornerRadius = AppTheme.Radius.card
        card.layer.borderWidth  = 1
        card.layer.borderColor  = AppTheme.Color.strokeLight.cgColor
        AppTheme.Shadow.card(on: card.layer)

        view.addSubview(card)
        card.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(28)
        }

        checkWrap.backgroundColor    = AppTheme.Color.success.withAlphaComponent(0.18)
        checkWrap.layer.cornerRadius = 36
        checkWrap.layer.shadowColor   = AppTheme.Color.success.cgColor
        checkWrap.layer.shadowOpacity = 0.5
        checkWrap.layer.shadowRadius  = 24
        card.addSubview(checkWrap)
        checkWrap.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(72)
        }

        checkImg.image       = UIImage(systemName: "checkmark.circle.fill")
        checkImg.tintColor   = AppTheme.Color.success
        checkImg.contentMode = .scaleAspectFit
        checkWrap.addSubview(checkImg)
        checkImg.snp.makeConstraints { $0.center.equalToSuperview(); $0.size.equalTo(36) }

        titleLabel.text          = titleText
        titleLabel.textColor     = AppTheme.Color.textPrimary
        titleLabel.font          = AppTheme.Font.bold(22)
        titleLabel.textAlignment = .center

        subLabel.text          = subtitleText
        subLabel.textColor     = AppTheme.Color.textSecondary
        subLabel.font          = AppTheme.Font.regular(14)
        subLabel.textAlignment = .center
        subLabel.numberOfLines = 2

        okButton.setTitle("Continue", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.titleLabel?.font   = AppTheme.Font.bold(16)
        okButton.backgroundColor    = AppTheme.Color.accent
        okButton.layer.cornerRadius = AppTheme.Radius.medium
        okButton.addTarget(self, action: #selector(tappedOK), for: .touchUpInside)

        card.addSubview(titleLabel)
        card.addSubview(subLabel)
        card.addSubview(okButton)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(checkWrap.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(20)
        }
        subLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
        }
        okButton.snp.makeConstraints {
            $0.top.equalTo(subLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(20)
        }
    }

    @objc private func tappedOK() {
        dismiss(animated: true) { [weak self] in self?.onDismiss?() }
    }
}
