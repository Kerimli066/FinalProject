import UIKit

final class LoginViewController: BaseAuthViewController {

    private let vm = LoginViewModel()
    private let overlay = LoadingOverlay()
    private let ui = LoginViewUI()

    override var entranceViews: [UIView] {
        [ui.headerStack, ui.formStack, ui.signInBtn, ui.socialStack, ui.bottomRow]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        LoginViewBinder.bind(vm: vm, vc: self, ui: ui, overlay: overlay)
        bindActions()
    }

    override func setupUI() {
        ui.build(in: contentView)
    }

    override func setupConstraints() {
        ui.applyConstraints()
    }

    func showInline(_ msg: String, label: UILabel, shake: UIView) {
        label.text = msg
        label.isHidden = false
        label.alpha = 0
        UIView.animate(withDuration: 0.2) { label.alpha = 1 }
        ScreenAnimator.shake(shake)
    }

    func clearErrors() {
        [ui.emailErrorLabel, ui.passErrorLabel].forEach {
            $0.alpha = 0
            $0.isHidden = true
        }
    }

    private func bindActions() {
        ui.signInBtn.addTarget(self, action: #selector(tappedSignIn), for: .touchUpInside)
        ui.googleBtn.addTarget(self, action: #selector(tappedGoogleAuth), for: .touchUpInside)
        ui.githubBtn.addTarget(self, action: #selector(tappedGithubAuth), for: .touchUpInside)
        ui.forgotBtn.addTarget(self, action: #selector(tappedForgot), for: .touchUpInside)
        ui.bottomAction.addTarget(self, action: #selector(tappedRegister), for: .touchUpInside)
    }

    @objc private func tappedSignIn() {
        clearErrors()
        vm.login(
            email: ui.emailField.text ?? "",
            password: ui.passField.textField.text ?? ""
        )
    }

    @objc private func tappedGoogleAuth() {
        vm.signInWithGoogle(from: self)
    }

    @objc private func tappedGithubAuth() {
        vm.signInWithGithub()
    }

    @objc private func tappedForgot() {
        vm.goForgot()
    }

    @objc private func tappedRegister() {
        vm.goRegister()
    }
}
