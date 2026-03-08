import UIKit
import SnapKit

final class SplashViewUI {

    let logoWrap = UIView()
    let logoIcon = UIImageView()

    let badgeWrap = UIView()
    let badgeIcon = UIImageView()

    let titleLabel = UILabel()
    let nameLabel = UILabel()
    let tagLabel = UILabel()

    let statusLabel = UILabel()
    let pctLabel = UILabel()

    let progressBg = UIView()
    let progressFill = UIView()

    let versionLabel = UILabel()
    let gradient = GradientView()

    func build(in view: UIView) {

        view.insertSubview(gradient, at: 0)
        gradient.snp.makeConstraints { $0.edges.equalToSuperview() }

        configureLogo()
        configureBadge()
        configureLabels()
        configureProgress()

        [logoWrap,badgeWrap,titleLabel,nameLabel,tagLabel,
         statusLabel,pctLabel,progressBg,versionLabel].forEach {
            view.addSubview($0)
            $0.alpha = 0
        }

        logoWrap.addSubview(logoIcon)
        badgeWrap.addSubview(badgeIcon)
        progressBg.addSubview(progressFill)

        applyConstraints(view)
    }

    private func configureLogo() {
        let sym = UIImage.SymbolConfiguration(pointSize: 60, weight: .regular)

        logoIcon.image = UIImage(systemName: "gearshape.fill", withConfiguration: sym)
        logoIcon.tintColor = .white
        logoIcon.contentMode = .scaleAspectFit

        logoIcon.layer.shadowColor = UIColor.white.cgColor
        logoIcon.layer.shadowRadius = 22
        logoIcon.layer.shadowOpacity = 0.28
    }

    private func configureBadge() {

        badgeWrap.backgroundColor = AppTheme.Color.accent
        badgeWrap.layer.cornerRadius = 13
        badgeWrap.layer.shadowColor = AppTheme.Color.accent.cgColor
        badgeWrap.layer.shadowRadius = 14
        badgeWrap.layer.shadowOpacity = 0.65

        let sym = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)

        badgeIcon.image = UIImage(systemName: "shippingbox.fill", withConfiguration: sym)
        badgeIcon.tintColor = .white
    }

    private func configureLabels() {

        titleLabel.text = "POCKET"
        titleLabel.font = AppTheme.Font.heavy(44)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        nameLabel.text = "Lumen"
        nameLabel.font = AppTheme.Font.heavy(44)
        nameLabel.textColor = AppTheme.Color.accent
        nameLabel.textAlignment = .center

        tagLabel.font = AppTheme.Font.semibold(11)
        tagLabel.textColor = AppTheme.Color.textMuted
        tagLabel.textAlignment = .center
        tagLabel.attributedText = letterSpaced("REAL-TIME CONTAINER MONITORING", spacing: 2.5)

        statusLabel.font = AppTheme.Font.mono(10)
        statusLabel.textColor = AppTheme.Color.textMuted
        statusLabel.text = "CONNECTING TO DOCKER ENGINE..."

        pctLabel.font = AppTheme.Font.bold(11)
        pctLabel.textColor = AppTheme.Color.accent
        pctLabel.text = "0%"
    }

    private func configureProgress() {

        progressBg.backgroundColor = AppTheme.Color.backgroundField
        progressBg.layer.cornerRadius = 2
        progressBg.clipsToBounds = true

        progressFill.backgroundColor = AppTheme.Color.accent
        progressFill.layer.cornerRadius = 2
        progressFill.layer.shadowColor = AppTheme.Color.accent.cgColor
        progressFill.layer.shadowRadius = 8
        progressFill.layer.shadowOpacity = 0.75

        versionLabel.font = AppTheme.Font.mono(9)
        versionLabel.textColor = UIColor(white: 0.3, alpha: 1)
        versionLabel.attributedText = letterSpaced("SYSTEM READY - V2.0.0", spacing: 1.5)
    }

    private func applyConstraints(_ view: UIView) {

        logoWrap.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-150)
            $0.size.equalTo(80)
        }

        logoIcon.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        badgeWrap.snp.makeConstraints {
            $0.trailing.equalTo(logoWrap.snp.trailing).offset(12)
            $0.bottom.equalTo(logoWrap.snp.bottom).offset(12)
            $0.size.equalTo(32)
        }

        badgeIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(18)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoWrap.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }

        tagLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(40)
        }

        progressBg.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(110)
            $0.left.right.equalToSuperview().inset(60)
            $0.height.equalTo(4)
        }

        progressFill.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(0)
        }

        statusLabel.snp.makeConstraints {
            $0.leading.equalTo(progressBg)
            $0.bottom.equalTo(progressBg.snp.top).offset(-14)
        }

        pctLabel.snp.makeConstraints {
            $0.trailing.equalTo(progressBg)
            $0.bottom.equalTo(statusLabel)
        }

        versionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(progressBg.snp.bottom).offset(16)
        }
    }

    private func letterSpaced(_ text: String, spacing: CGFloat) -> NSAttributedString {
        NSAttributedString(string: text, attributes: [.kern: spacing])
    }
}
