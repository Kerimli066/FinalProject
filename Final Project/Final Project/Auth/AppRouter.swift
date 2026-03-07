
import UIKit
import FirebaseAuth

enum AppRouter {

    static func setRoot(window: UIWindow) {
        Task { @MainActor in
            let root = await makeRootController()
            let nav  = UINavigationController(rootViewController: root)
            nav.setNavigationBarHidden(true, animated: false)
            nav.delegate = PremiumNavDelegate.shared
            ScreenAnimator.windowTransition(window: window, to: nav)
        }
    }

    @MainActor
    private static func makeRootController() async -> UIViewController {
        if let user = Auth.auth().currentUser {
            try? await user.reload()
        }

        let onboardingDone = UserDefaults.standard.bool(forKey: AppFlags.hasCompletedOnboarding)
        guard onboardingDone else { return OnboardingViewController() }

        guard Auth.auth().currentUser != nil else { return AutoChoiceViewController() }

        if AppConfig.useMock {
            return MainTabBarController()
        }

        if !ServerConfig.shared.isConfigured {
            let serverVC = ServerSetupViewController()
            serverVC.onComplete = {
                guard let window = UIApplication.shared
                    .connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .flatMap({ $0.windows })
                    .first(where: { $0.isKeyWindow }) else { return }
                AppRouter.setRoot(window: window)
            }
            return serverVC
        }

        return MainTabBarController()
    }

    static func routeToMain(from vc: UIViewController) {
        guard let window = vc.window else { return }
        setRoot(window: window)
    }

    static func routeToAuth(from vc: UIViewController) {
        guard let window = vc.window else { return }
        Task { @MainActor in
            let nav = UINavigationController(rootViewController: AutoChoiceViewController())
            nav.setNavigationBarHidden(true, animated: false)
            nav.delegate = PremiumNavDelegate.shared
            ScreenAnimator.windowTransition(window: window, to: nav)
        }
    }
}

private extension UIViewController {
    var window: UIWindow? { view.window ?? navigationController?.view.window }
}
