//
//  RegisterViewBinder.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//


import UIKit

final class RegisterViewBinder {

    static func bind(
        vm: RegisterViewModel,
        vc: RegisterViewController,
        ui: RegisterViewUI,
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

            let emailErrors: Set<String> = [
                "Email address is required.",
                "Enter the part before '@' — e.g. name@gmail.com",
                "Enter a domain after '@' — e.g. gmail.com",
                "Domain must include '.' — e.g. name@gmail.com",
                "Domain extension is too short — e.g. .com or .net",
                "Enter a valid email address — e.g. name@gmail.com",
                "Enter a valid email — e.g. name@gmail.com"
            ]
            let passErrors: Set<String> = [
                "Password is required.",
                "Password must be at least 8 characters.",
                "Password is too long. Maximum 128 characters.",
                "Password must contain at least one number or special character.",
                "Passwords do not match."
            ]

            let isEmailValidation = emailErrors.contains(msg) || msg.contains("must include '@'") || msg.contains("Did you mean") || msg.contains("is not allowed")
            let isPassValidation = passErrors.contains(msg)

            if isEmailValidation {
                vc.showInline(msg, label: ui.emailErrorLabel, shake: ui.emailField)
            } else if isPassValidation {
                vc.showInline(msg, label: ui.passErrorLabel, shake: ui.passField)
            } else {
                AuthUIHelper.showAlert(on: vc, title: "Error", message: msg)
            }
        }

        vm.onRoute = { [weak vc] route in
            guard let vc else { return }
            switch route {
            case .goLogin:
                vc.navigationController?.popViewController(animated: true)
            case .goVerify(let email):
                vc.navigationController?.pushViewController(EmailVerificationViewController(email: email), animated: true)
            case .finished(let isNew):
                Task { @MainActor in
                    AuthFlowHelper.handlePostAuth(from: vc, isNewUser: isNew)
                }
            }
        }
    }
}