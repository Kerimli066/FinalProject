import UIKit

final class OnboardingViewControllerAnimationHelper {

    unowned let owner: OnboardingViewController

    private lazy var entranceAnimator = OnboardingEntranceAnimator(owner: owner)
    private lazy var transitionAnimator = OnboardingTransitionAnimator(owner: owner)
    private lazy var toneStyler = OnboardingToneStyler(owner: owner)

    init(owner: OnboardingViewController) {
        self.owner = owner
    }

    func prepareInitialEntranceState() {
        entranceAnimator.prepareInitialEntranceState()
    }

    func runInitialEntranceIfNeeded() {
        entranceAnimator.runInitialEntranceIfNeeded()
    }

    func performTransition(to step: OnboardingStep, tone: UIColor) {
        transitionAnimator.performTransition(to: step, tone: tone)
    }

    func applyToneColor(_ tone: UIColor) {
        toneStyler.applyToneColor(tone)
    }

    func applyGlow(tone: UIColor) {
        toneStyler.applyGlow(tone: tone)
    }

    func animateCardPulse() {
        toneStyler.animateCardPulse()
    }

    func applyDots(activeIndex: Int, tone: UIColor, animated: Bool) {
        toneStyler.applyDots(activeIndex: activeIndex, tone: tone, animated: animated)
    }
}
