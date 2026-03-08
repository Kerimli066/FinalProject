import UIKit

final class EmailVerificationViewController: BaseAuthViewController {

    private let email: String
    private let vm = EmailVerificationViewModel()
    private let overlay = LoadingOverlay()
    private let ui = EmailVerificationUI()

    override var entranceViews: [UIView] {
        [ui.headerStack, ui.emailCard, ui.actionStack, ui.hintLabel]
    }

    init(email: String) {
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.build(in: contentView, email: email)
        EmailVerificationBinder.bind(vm: vm, vc: self, ui: ui)
        vm.startAutoCheck()
        ScreenAnimator.glowPulse(ui.iconWrap, color: AppTheme.Color.accent)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        vm.stopTimers()
        ScreenAnimator.stopGlowPulse(ui.iconWrap)
    }

    @objc func tappedOpenMail() {
        ScreenAnimator.pressBounce(ui.openMailBtn)
        let apps = ["googlegmail://", "ms-outlook://", "ymail://", "message://", "mailto:"]
        for urlStr in apps {
            if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                return
            }
        }
        AuthUIHelper.showAlert(on: self, title: "No Mail App", message: "Please open your mail app manually.")
    }

    @objc func tappedCheck() {
        ScreenAnimator.pressBounce(ui.checkBtn)
        overlay.show(in: view)
        view.isUserInteractionEnabled = false

        Task {
            let verified = await vm.manualCheck()
            await MainActor.run {
                self.overlay.hide()
                self.view.isUserInteractionEnabled = true
                if verified {
                    self.vm.stopTimers()
                    self.showSuccessAndRoute()
                } else {
                    ScreenAnimator.shake(self.ui.checkBtn)
                    AuthUIHelper.showAlert(on: self, title: "Not Verified Yet", message: "Please tap the link in the email first, then try again.")
                }
            }
        }
    }

    @objc func tappedResend() {
        guard !vm.isOnCooldown else { return }
        ui.resendBtn.isEnabled = false
        Task { await vm.resendVerification() }
    }

    func showSuccessAndRoute() {
        ScreenAnimator.stopGlowPulse(ui.iconWrap)
        UIView.animate(withDuration: 0.35) {
            self.ui.iconImg.tintColor = AppTheme.Color.success
            self.ui.iconWrap.backgroundColor = AppTheme.Color.success.withAlphaComponent(0.12)
            self.ui.iconWrap.layer.borderColor = AppTheme.Color.success.withAlphaComponent(0.3).cgColor
        }
        ScreenAnimator.glowPulse(ui.iconWrap, color: AppTheme.Color.success)

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 400_000_000)
            let popup = SuccessPopupViewController(title: "Email Verified!", subtitle: "Your account is fully activated.\nWelcome aboard!")
            popup.onDismiss = { [weak self] in
                guard let self else { return }
                AuthFlowHelper.handlePostAuth(from: self, isNewUser: true)
            }
            self.present(popup, animated: true)
        }
    }
}
