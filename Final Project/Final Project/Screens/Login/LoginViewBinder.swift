import UIKit

final class LoginViewBinder {

    static func bind(
        vm: LoginViewModel,
        vc: LoginViewController,
        ui: LoginViewUI,
        overlay: LoadingOverlay
    ) {
        vm.onLoading = { [weak vc] loading in
            guard let vc else { return }
            loading ? overlay.show(in: vc.view) : overlay.hide()
            vc.view.isUserInteractionEnabled = !loading
        }

        vm.onError = { [weak vc] msg in
            guard let vc else { return }
            vc.clearErrors()

            if msg == "Please enter your email address." || msg.contains("must include '@'") {
                vc.showInline(msg, label: ui.emailErrorLabel, shake: ui.emailField)
            } else if msg == "Please enter your password." {
                vc.showInline(msg, label: ui.passErrorLabel, shake: ui.passField)
            } else {
                AuthUIHelper.showAlert(on: vc, title: "Error", message: msg)
            }
        }

        vm.onEmailNotVerified = { [weak vc] _, resend in
            guard let vc else { return }
            AuthUIHelper.showEmailNotVerified(on: vc, onResend: resend)
        }

        vm.onRoute = { [weak vc] route in
            guard let vc else { return }

            switch route {
            case .goRegister:
                vc.navigationController?.pushViewController(
                    RegisterViewController(),
                    animated: true
                )

            case .goForgot:
                vc.navigationController?.pushViewController(
                    ForgotViewController(),
                    animated: true
                )

            case .finished(let isNew):
                Task { @MainActor in
                    AuthFlowHelper.handlePostAuth(from: vc, isNewUser: isNew)
                }
            }
        }
    }
}
