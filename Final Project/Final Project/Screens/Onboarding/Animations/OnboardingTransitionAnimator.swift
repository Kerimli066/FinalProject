import UIKit

final class OnboardingTransitionAnimator {

    unowned let owner: OnboardingViewController
    private lazy var toneStyler = OnboardingToneStyler(owner: owner)

    init(owner: OnboardingViewController) {
        self.owner = owner
    }

    func performTransition(to step: OnboardingStep, tone: UIColor) {
        guard !owner.isAnimating else { return }
        owner.isAnimating = true

        owner.ambientGlow.applyTone(tone, animated: true)
        toneStyler.applyToneColor(tone)
        toneStyler.applyGlow(tone: tone)
        toneStyler.applyDots(activeIndex: step.rawValue, tone: tone, animated: true)

        UIView.transition(
            with: owner.imageView,
            duration: 0.35,
            options: [.transitionCrossDissolve, .allowUserInteraction, .beginFromCurrentState]
        ) {
            self.owner.imageView.image = UIImage(named: "onboarding\(step.rawValue + 1)")
        }

        UIView.animate(
            withDuration: 0.16,
            delay: 0,
            options: [.curveEaseInOut, .beginFromCurrentState]
        ) {
            self.owner.titleLabel.alpha = 0
            self.owner.descLabel.alpha = 0
            self.owner.titleLabel.transform = CGAffineTransform(translationX: 0, y: 6)
            self.owner.descLabel.transform = CGAffineTransform(translationX: 0, y: 6)
        } completion: { [weak self] _ in
            guard let self else { return }

            self.owner.uiHelper.applyText(step: step)

            self.owner.titleLabel.transform = CGAffineTransform(translationX: 0, y: 10)
            self.owner.descLabel.transform = CGAffineTransform(translationX: 0, y: 10)

            UIView.animate(
                withDuration: 0.32,
                delay: 0.02,
                usingSpringWithDamping: 0.95,
                initialSpringVelocity: 0.02,
                options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState]
            ) {
                self.owner.titleLabel.alpha = 1
                self.owner.descLabel.alpha = 1
                self.owner.titleLabel.transform = .identity
                self.owner.descLabel.transform = .identity
            } completion: { [weak self] _ in
                self?.owner.isAnimating = false
            }
        }
    }
}
