import UIKit

final class RegisterViewController: BaseAuthViewController {

    private let vm = RegisterViewModel()
    private let overlay = LoadingOverlay()
    private let ui = RegisterViewUI()

    override var entranceViews: [UIView] {
        [ui.headerStack, ui.formStack, ui.createBtn, ui.socialStack, ui.bottomRow]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.build(in: contentView, target: self)
        RegisterViewBinder.bind(vm: vm, vc: self, ui: ui, overlay: overlay)
        bindActions()
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
        ui.createBtn.addTarget(self, action: #selector(tappedCreate), for: .touchUpInside)
        ui.googleBtn.addTarget(self, action: #selector(tappedGoogle), for: .touchUpInside)
        ui.githubBtn.addTarget(self, action: #selector(tappedGithub), for: .touchUpInside)
    }

    @objc private func tappedCreate() {
        clearErrors()
        vm.register(email: ui.emailField.text ?? "", password: ui.passField.textField.text ?? "")
    }

    @objc private func tappedGoogle() { vm.signInWithGoogle(from: self) }
    @objc private func tappedGithub() { vm.signInWithGithub() }

    @objc func tappedLogin() {
        let vcs = navigationController?.viewControllers ?? []
        if let login = vcs.first(where: { $0 is LoginViewController }) {
            navigationController?.popToViewController(login, animated: true)
        } else {
            navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
}
