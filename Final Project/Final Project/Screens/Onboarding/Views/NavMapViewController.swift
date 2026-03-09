import UIKit

final class NavMapViewController: UIViewController {

    private let ui = NavMapViewUI()
    private let animator = NavMapAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.Color.backgroundPrimary
        navigationItem.hidesBackButton = true
        ui.build(in: view, target: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animator.runEntranceAnimation(
            cards: ui.moduleCards,
            startButton: ui.startButton
        )
    }

    @objc func tappedStart() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        guard let window = view.window else { return }

        UIView.animate(withDuration: 0.12) {
            self.ui.startButton.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        } completion: { _ in
            UIView.animate(
                withDuration: 0.22,
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.3
            ) {
                self.ui.startButton.transform = .identity
            }

            Task { @MainActor [weak self] in
                guard self != nil else { return }
                try? await Task.sleep(nanoseconds: 120_000_000)
                UserDefaults.standard.set(true, forKey: AppFlags.hasSeenNavMap)
                UserDefaults.standard.set(true, forKey: AppFlags.hasCompletedOnboarding)
                AppRouter.setRoot(window: window)
            }
        }
    }
}
