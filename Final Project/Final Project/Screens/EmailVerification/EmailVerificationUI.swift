import UIKit
import SnapKit

final class EmailVerificationUI {

    let iconWrap = UIView(), iconImg = UIImageView(), titleLabel = UILabel(), descLabel = UILabel()
    let headerStack = UIStackView(), emailCard = UIView(), emailLbl = UILabel()
    let openMailBtn = PrimaryButton(title: "Open Mail App"), checkBtn = UIButton(type: .system)
    let resendBtn = UIButton(type: .system), actionStack = UIStackView(), hintLabel = UILabel()

    func build(in contentView: UIView, email: String) {
        let sym = UIImage.SymbolConfiguration(pointSize: 32, weight: .semibold)
        iconImg.image = UIImage(systemName: "envelope.badge.fill", withConfiguration: sym)
        iconImg.tintColor = AppTheme.Color.accent
        iconImg.contentMode = .scaleAspectFit

        iconWrap.backgroundColor = AppTheme.Color.accent.withAlphaComponent(0.12)
        iconWrap.layer.cornerRadius = 32
        iconWrap.layer.borderWidth = 1
        iconWrap.layer.borderColor = AppTheme.Color.accent.withAlphaComponent(0.3).cgColor
        iconWrap.addSubview(iconImg)

        titleLabel.text = "Check Your Inbox"
        titleLabel.font = AppTheme.Font.bold(30)
        titleLabel.textColor = AppTheme.Color.textPrimary
        titleLabel.textAlignment = .center

        descLabel.text = "We've sent a verification link to:"
        descLabel.font = AppTheme.Font.regular(15)
        descLabel.textColor = AppTheme.Color.textSecondary
        descLabel.textAlignment = .center

        headerStack.axis = .vertical
        headerStack.spacing = AppTheme.Spacing.sm
        headerStack.alignment = .center
        [iconWrap, titleLabel, descLabel].forEach { headerStack.addArrangedSubview($0) }

        emailCard.backgroundColor = AppTheme.Color.backgroundField
        emailCard.layer.cornerRadius = AppTheme.Radius.medium
        emailCard.layer.borderWidth = 1
        emailCard.layer.borderColor = AppTheme.Color.accent.withAlphaComponent(0.3).cgColor
        emailLbl.text = email
        emailLbl.font = AppTheme.Font.bold(16)
        emailLbl.textColor = AppTheme.Color.accent
        emailLbl.textAlignment = .center
        emailLbl.adjustsFontSizeToFitWidth = true
        emailCard.addSubview(emailLbl)

        openMailBtn.snp.makeConstraints { $0.height.equalTo(58) }
        checkBtn.setTitle("I've Verified My Email ✓", for: .normal)
        checkBtn.setTitleColor(AppTheme.Color.textPrimary, for: .normal)
        checkBtn.titleLabel?.font = AppTheme.Font.semibold(16)
        checkBtn.backgroundColor = AppTheme.Color.backgroundField
        checkBtn.layer.cornerRadius = AppTheme.Radius.medium
        checkBtn.layer.borderWidth = 1
        checkBtn.layer.borderColor = AppTheme.Color.strokeLight.cgColor
        checkBtn.snp.makeConstraints { $0.height.equalTo(54) }

        resendBtn.setTitle("Resend Verification Email", for: .normal)
        resendBtn.setTitleColor(AppTheme.Color.textSecondary, for: .normal)
        resendBtn.titleLabel?.font = AppTheme.Font.semibold(14)

        actionStack.axis = .vertical
        actionStack.spacing = AppTheme.Spacing.sm
        [openMailBtn, checkBtn, resendBtn].forEach { actionStack.addArrangedSubview($0) }

        hintLabel.text = "💡 Don't see it? Check your Spam or Junk folder."
        hintLabel.font = AppTheme.Font.regular(13)
        hintLabel.textColor = AppTheme.Color.textMuted
        hintLabel.textAlignment = .center
        hintLabel.numberOfLines = 2

        [headerStack, emailCard, actionStack, hintLabel].forEach { contentView.addSubview($0) }
        iconWrap.snp.makeConstraints { $0.size.equalTo(80) }
        iconImg.snp.makeConstraints { $0.center.equalToSuperview(); $0.size.equalTo(34) }
        emailLbl.snp.makeConstraints { $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)) }
        headerStack.snp.makeConstraints { $0.top.equalToSuperview().inset(32); $0.left.right.equalToSuperview().inset(AppTheme.Spacing.lg) }
        emailCard.snp.makeConstraints { $0.top.equalTo(headerStack.snp.bottom).offset(AppTheme.Spacing.md); $0.left.right.equalToSuperview().inset(AppTheme.Spacing.lg) }
        actionStack.snp.makeConstraints { $0.top.equalTo(emailCard.snp.bottom).offset(AppTheme.Spacing.xl); $0.left.right.equalToSuperview().inset(AppTheme.Spacing.lg) }
        hintLabel.snp.makeConstraints { $0.top.equalTo(actionStack.snp.bottom).offset(AppTheme.Spacing.md); $0.left.right.equalToSuperview().inset(AppTheme.Spacing.lg); $0.bottom.equalToSuperview().inset(16) }
    }
}
