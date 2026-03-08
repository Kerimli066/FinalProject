import UIKit
import SnapKit


final class ForgotViewController: BaseAuthViewController {

    private let vm      = ForgotViewModel()
    private let overlay = LoadingOverlay()

    private let iconWrap    = UIView()
    private let iconImg     = UIImageView()
    private let titleLabel  = UILabel()
    private let subLabel    = UILabel()
    private let headerStack = UIStackView()
    private let emailLabel  = UILabel()
    private let emailField  = AppTextField(placeholder: "name@example.com", keyboard: .emailAddress)
    private let sendBtn     = PrimaryButton(title: "Send Reset Link")
    private let formStack   = UIStackView()
    private let hintLabel   = UILabel()

    override var entranceViews: [UIView] { [headerStack, formStack, hintLabel] }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindVM()
        sendBtn.addTarget(self, action: #selector(tappedSend), for: .touchUpInside)
    }

    // MARK: Setup

    override func setupUI() {
        let sym = UIImage.SymbolConfiguration(pointSize: 26, weight: .semibold)
        iconImg.image       = UIImage(systemName: "lock.rotation", withConfiguration: sym)
        iconImg.tintColor   = AppTheme.Color.accent
        iconImg.contentMode = .scaleAspectFit

        iconWrap.backgroundColor    = AppTheme.Color.accent.withAlphaComponent(0.13)
        iconWrap.layer.cornerRadius = 22
        iconWrap.layer.borderWidth  = 1
        iconWrap.layer.borderColor  = AppTheme.Color.accent.withAlphaComponent(0.3).cgColor
        AppTheme.Shadow.accent(on: iconWrap.layer)
        iconWrap.addSubview(iconImg)

        titleLabel.text      = "Reset Password"
        titleLabel.font      = AppTheme.Font.bold(28)
        titleLabel.textColor = AppTheme.Color.textPrimary

        subLabel.text          = "Enter your email and we'll send you a secure reset link."
        subLabel.font          = AppTheme.Font.regular(15)
        subLabel.textColor     = AppTheme.Color.textSecondary
        subLabel.numberOfLines = 2

        headerStack.axis      = .vertical
        headerStack.spacing   = 10
        headerStack.alignment = .leading
        headerStack.addArrangedSubview(iconWrap)
        headerStack.setCustomSpacing(18, after: iconWrap)
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(subLabel)

        emailLabel.text      = "EMAIL ADDRESS"
        emailLabel.font      = AppTheme.Font.bold(11)
        emailLabel.textColor = AppTheme.Color.textSecondary

        formStack.axis    = .vertical
        formStack.spacing = 10
        formStack.addArrangedSubview(emailLabel)
        formStack.addArrangedSubview(emailField)
        formStack.addArrangedSubview(sendBtn)

        hintLabel.text          = "💡 Check your Spam folder if you don't see it within a minute."
        hintLabel.font          = AppTheme.Font.regular(13)
        hintLabel.textColor     = AppTheme.Color.textMuted
        hintLabel.textAlignment = .left
        hintLabel.numberOfLines = 2

        contentView.addSubview(headerStack)
        contentView.addSubview(formStack)
        contentView.addSubview(hintLabel)
    }

    override func setupConstraints() {
        iconWrap.snp.makeConstraints  { $0.size.equalTo(64) }
        iconImg.snp.makeConstraints   { $0.center.equalToSuperview(); $0.size.equalTo(28) }
        emailField.snp.makeConstraints { $0.height.equalTo(52) }
        sendBtn.snp.makeConstraints    { $0.height.equalTo(56) }

        headerStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(72)
            $0.left.right.equalToSuperview().inset(24)
        }
        formStack.snp.makeConstraints {
            $0.top.equalTo(headerStack.snp.bottom).offset(28)
            $0.left.right.equalToSuperview().inset(24)
        }
        hintLabel.snp.makeConstraints {
            $0.top.equalTo(formStack.snp.bottom).offset(18)
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.lessThanOrEqualToSuperview().inset(24)
        }
    }

    // MARK: Bind VM

    private func bindVM() {
        vm.onLoading = { [weak self] loading in
            guard let self else { return }
            loading ? overlay.show(in: view) : overlay.hide()
            view.isUserInteractionEnabled = !loading
        }
        vm.onError = { [weak self] msg in
            guard let self else { return }
            AuthUIHelper.showAlert(on: self, title: "Error", message: msg)
        }
        vm.onSent = { [weak self] email in
            guard let self else { return }
            AuthUIHelper.showPasswordResetSent(on: self, email: email)
        }
    }

    @objc private func tappedSend() {
        vm.send(email: emailField.text ?? "")
    }
}
