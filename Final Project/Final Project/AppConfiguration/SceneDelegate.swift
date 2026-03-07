import UIKit
import GoogleSignIn
import FirebaseAuth

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let w = UIWindow(windowScene: windowScene)
        w.backgroundColor = AppTheme.Color.backgroundPrimary

        let splash = SplashViewController()
        let nav    = UINavigationController(rootViewController: splash)
        nav.setNavigationBarHidden(true, animated: false)
        nav.delegate = PremiumNavDelegate.shared

        w.rootViewController = nav
        w.makeKeyAndVisible()
        self.window = w
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        if Auth.auth().canHandle(url) { return }
        GIDSignIn.sharedInstance.handle(url)
    }
}
