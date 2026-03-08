//
//  EmailVerificationBinder.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//


import UIKit

final class EmailVerificationBinder {

    static func bind(
        vm: EmailVerificationViewModel,
        vc: EmailVerificationViewController,
        ui: EmailVerificationUI
    ) {
        ui.openMailBtn.addTarget(vc, action: #selector(vc.tappedOpenMail), for: .touchUpInside)
        ui.checkBtn.addTarget(vc, action: #selector(vc.tappedCheck), for: .touchUpInside)
        ui.resendBtn.addTarget(vc, action: #selector(vc.tappedResend), for: .touchUpInside)

        vm.onVerified = { [weak vc] in
            vc?.showSuccessAndRoute()
        }

        vm.onCooldownTick = { [weak ui] remaining in
            ui?.resendBtn.setTitle("Resend in \(remaining)s", for: .normal)
            ui?.resendBtn.setTitleColor(AppTheme.Color.textMuted, for: .normal)
        }

        vm.onCooldownEnd = { [weak ui] in
            ui?.resendBtn.isEnabled = true
            ui?.resendBtn.setTitle("Resend Verification Email", for: .normal)
            ui?.resendBtn.setTitleColor(AppTheme.Color.textSecondary, for: .normal)
        }

        vm.onResendSuccess = { [weak vc] message in
            guard let vc else { return }
            AuthUIHelper.showAlert(on: vc, title: "Email Sent ✉️", message: message)
        }

        vm.onResendError = { [weak vc, weak ui] message in
            guard let vc else { return }
            ui?.resendBtn.isEnabled = true
            AuthUIHelper.showAlert(on: vc, title: "Could Not Send", message: message)
        }

        vm.onCheckError = { [weak vc] message in
            guard let vc else { return }
            AuthUIHelper.showAlert(on: vc, title: "Error", message: message)
        }
    }
}