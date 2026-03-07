//
//  AuthUIHelper.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import UIKit
enum AuthUIHelper {

    static func showAlert(on vc: UIViewController,
                          title: String,
                          message: String,
                          completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in completion?() })
        vc.present(alert, animated: true)
    }

    static func showEmailVerificationSent(on vc: UIViewController,
                                          email: String,
                                          onResend: @escaping () -> Void) {
        let alert = UIAlertController(
            title: "Verify Your Email",
            message: "A verification link has been sent to:\n\(email)\n\nCheck your inbox and tap the link.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Open Mail App", style: .default) { _ in openMailApp(from: vc) })
        alert.addAction(UIAlertAction(title: "Resend Email", style: .default) { _ in onResend() })
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        vc.present(alert, animated: true)
    }

    static func showEmailNotVerified(on vc: UIViewController,
                                     onResend: @escaping () -> Void) {
        let alert = UIAlertController(
            title: "Email Not Verified",
            message: "Please verify your email before signing in.\nCheck your inbox for the verification link.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Open Mail App", style: .default) { _ in openMailApp(from: vc) })
        alert.addAction(UIAlertAction(title: "Resend Email", style: .default) { _ in onResend() })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        vc.present(alert, animated: true)
    }

    static func showPasswordResetSent(on vc: UIViewController, email: String) {
        let alert = UIAlertController(
            title: "Reset Link Sent",
            message: "A password reset link has been sent to:\n\(email)\n\nCheck your Spam folder if not visible.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Open Mail App", style: .default) { _ in openMailApp(from: vc) })
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        vc.present(alert, animated: true)
    }

    static func openMailApp(from vc: UIViewController) {
        let candidates = ["googlegmail://", "ms-outlook://", "ymail://", "message://", "mailto:"]
            .compactMap { URL(string: $0) }
        for url in candidates where UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url); return
        }
        showAlert(on: vc, title: "No Mail App", message: "No mail app was found on this device.")
    }
}
