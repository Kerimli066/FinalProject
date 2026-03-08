import UIKit

final class SplashViewController: UIViewController {

    private let vm = SplashViewModel()
    private let ui = SplashViewUI()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppTheme.Color.backgroundPrimary

        ui.build(in: view)
        SplashViewBinder.bind(vm: vm, vc: self, ui: ui)

        startEntrance()
    }

    func resolveWindow() -> UIWindow? {
        if let w = view.window { return w }

        return UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }

    private func startEntrance() {

        let secondaryItems: [UIView] = [
            ui.titleLabel,
            ui.nameLabel,
            ui.tagLabel,
            ui.statusLabel,
            ui.pctLabel,
            ui.progressBg,
            ui.versionLabel
        ]

        ScreenAnimator.splashLogoEntrance(ui.logoWrap, badge: ui.badgeWrap) { [weak self] in
            guard let self else { return }
            ScreenAnimator.startGearRotation(self.ui.logoIcon)
            ScreenAnimator.startLogoPulse(self.ui.logoWrap)
        }

        ScreenAnimator.splashItemsEntrance(secondaryItems) { [weak self] in
            self?.vm.startLoading()
        }
    }

    deinit {
        vm.stopLoading()
    }
}
