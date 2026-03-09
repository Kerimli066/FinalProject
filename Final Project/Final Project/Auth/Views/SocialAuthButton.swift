//
//  SocialAuthButton.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import UIKit
import SnapKit
final class SocialAuthButton: UIControl {
    enum SocialProvider {
        case googleAuth, githubAuth

        var title: String {
            switch self {
            case .googleAuth: return "Continue with Google"
            case .githubAuth: return "Continue with GitHub"
            }
        }
        var bgColor: UIColor {
            switch self {
            case .googleAuth: return .white
            case .githubAuth: return UIColor(hex: "#161B22")
            }
        }
        var textColor: UIColor {
            switch self {
            case .googleAuth: return UIColor(hex: "#1F1F1F")
            case .githubAuth: return .white
            }
        }
        var icon: UIImage? {
            switch self {
            case .googleAuth: return UIImage(named: "google")
            case .githubAuth: return UIImage(named: "github")
            }
        }
    }

    enum Style { case iconOnly, full }

    private let container  = UIView()
    private let iconView   = UIImageView()
    private let titleLabel = UILabel()


    init(provider: SocialProvider, style: Style) {
        super.init(frame: .zero)

        addSubview(container)
        container.snp.makeConstraints { $0.edges.equalToSuperview() }
        container.isUserInteractionEnabled = false
        container.backgroundColor          = provider.bgColor
        container.layer.cornerRadius       = AppTheme.Radius.medium
        container.layer.borderWidth        = 1
        container.layer.borderColor        = UIColor.black.withAlphaComponent(0.1).cgColor
        container.clipsToBounds            = true
        AppTheme.Shadow.subtle(on: layer)

        iconView.image         = provider.icon
        iconView.contentMode   = .scaleAspectFit
        iconView.clipsToBounds = true
        container.addSubview(iconView)

        if style == .iconOnly {
            iconView.snp.makeConstraints { $0.center.equalToSuperview(); $0.size.equalTo(28) }
            snp.makeConstraints { $0.size.equalTo(56) }
        } else {
            titleLabel.text      = provider.title
            titleLabel.textColor = provider.textColor
            titleLabel.font      = AppTheme.Font.semibold(15)
            container.addSubview(titleLabel)

            iconView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.left.equalToSuperview().inset(18)
                $0.size.equalTo(26)
            }
            titleLabel.snp.makeConstraints { $0.center.equalToSuperview() }
            snp.makeConstraints { $0.height.equalTo(56) }
        }

        addTarget(self, action: #selector(pressDown), for: .touchDown)
        addTarget(self, action: #selector(pressUp),   for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pressDown() {
        ScreenAnimator.highlight(self, enabled: false, duration: 0.1)
        ScreenAnimator.scaleDown(self)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    @objc private func pressUp() {
        ScreenAnimator.highlight(self, enabled: true, duration: 0.15)
        ScreenAnimator.scaleRestore(self)
    }
}
