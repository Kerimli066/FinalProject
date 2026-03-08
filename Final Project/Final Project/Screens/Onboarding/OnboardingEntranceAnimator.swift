import UIKit

final class OnboardingEntranceAnimator {

    unowned let owner: OnboardingViewController

    init(owner: OnboardingViewController) {
        self.owner = owner
    }

    func prepareInitialEntranceState() {
        [
            owner.stepLabel,
            owner.skipButton,
            owner.imageCard,
            owner.titleLabel,
            owner.descLabel,
            owner.dotsStack,
            owner.actionButton,
            owner.ambientGlow
        ].forEach {
            $0.alpha = 0
            $0.transform = .identity
        }

        owner.ambientGlow.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        owner.imageCard.transform   = CGAffineTransform(translationX: 0, y: 20)
        owner.titleLabel.transform  = CGAffineTransform(translationX: 0, y: 12)
        owner.descLabel.transform   = CGAffineTransform(translationX: 0, y: 12)
        owner.dotsStack.transform   = CGAffineTransform(translationX: 0, y: 10)
        owner.actionButton.transform = CGAffineTransform(translationX: 0, y: 14)
    }

    func runInitialEntranceIfNeeded() {
        guard !owner.didRunInitialEntrance else { return }
        owner.didRunInitialEntrance = true

        UIView.animate(
            withDuration: 0.45,
            delay: 0.02,
            options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState]
        ) {
            self.owner.stepLabel.alpha = 1
            self.owner.skipButton.alpha = 1
        }

        UIView.animate(
            withDuration: 0.60,
            delay: 0.05,
            usingSpringWithDamping: 0.96,
            initialSpringVelocity: 0.03,
            options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState]
        ) {
            self.owner.ambientGlow.alpha = 1
            self.owner.ambientGlow.transform = .identity
        }

        UIView.animate(
            withDuration: 0.62,
            delay: 0.08,
            usingSpringWithDamping: 0.94,
            initialSpringVelocity: 0.03,
            options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState]
        ) {
            self.owner.imageCard.alpha = 1
            self.owner.imageCard.transform = .identity
        }

        UIView.animate(
            withDuration: 0.42,
            delay: 0.16,
            options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState]
        ) {
            self.owner.titleLabel.alpha = 1
            self.owner.titleLabel.transform = .identity
        }

        UIView.animate(
            withDuration: 0.42,
            delay: 0.22,
            options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState]
        ) {
            self.owner.descLabel.alpha = 1
            self.owner.descLabel.transform = .identity
        }

        UIView.animate(
            withDuration: 0.40,
            delay: 0.28,
            options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState]
        ) {
            self.owner.dotsStack.alpha = 1
            self.owner.dotsStack.transform = .identity
        }

        UIView.animate(
            withDuration: 0.44,
            delay: 0.34,
            options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState]
        ) {
            self.owner.actionButton.alpha = 1
            self.owner.actionButton.transform = .identity
        }
    }
}
