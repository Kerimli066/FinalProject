import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {

    let vm       = OnboardingViewModel()
    let feedback = UIImpactFeedbackGenerator(style: .medium)

    let gradient     = GradientView()
    let ambientGlow  = OnboardingCardGlowView()
    let imageCard    = UIView()
    let imageView    = UIImageView()
    let glowLayer    = CAGradientLayer()
    let stepLabel    = UILabel()
    let skipButton   = UIButton(type: .system)
    let backButton   = UIButton(type: .system)
    let titleLabel   = UILabel()
    let descLabel    = UILabel()
    let dotsStack    = UIStackView()
    let actionButton = UIButton(type: .system)
    let arrowImg     = UIImageView()

    var dotViews: [UIView] = []
    var dotWidthConstraints: [Constraint] = []

    var didRunInitialEntrance = false
    var isAnimating = false

    lazy var uiHelper            = OnboardingViewControllerUIHelper(owner: self)
    lazy var entranceAnimator    = OnboardingEntranceAnimator(owner: self)
    lazy var transitionAnimator  = OnboardingTransitionAnimator(owner: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppTheme.Color.backgroundPrimary

        uiHelper.buildUI()
        bindVM()

        uiHelper.applyStep(step: .monitor, animated: false)
        entranceAnimator.prepareInitialEntranceState()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        entranceAnimator.runInitialEntranceIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        glowLayer.frame = imageCard.bounds
        glowLayer.cornerRadius = AppTheme.Radius.card

        imageCard.layer.shadowPath = UIBezierPath(
            roundedRect: imageCard.bounds,
            cornerRadius: AppTheme.Radius.card
        ).cgPath
    }

    private func bindVM() {
        vm.onStepChanged = { [weak self] step in
            guard let self else { return }

            if self.didRunInitialEntrance {
                self.transitionAnimator.performTransition(to: step, tone: step.accentColor)
            } else {
                self.uiHelper.applyStep(step: step, animated: false)
            }
        }

        vm.onFinish = { [weak self] in
            self?.navigateForward()
        }
    }

    @objc func tappedBack() {
        guard let p = OnboardingStep(rawValue: vm.currentStep.rawValue - 1) else { return }
        vm.goTo(p)
    }

    @objc func tappedSkip() {
        vm.skip()
    }

    @objc func tappedAction() {
        vm.handleAction()
    }

    private func navigateForward() {
        UserDefaults.standard.set(true, forKey: AppFlags.hasCompletedOnboarding)
        navigationController?.pushViewController(AutoChoiceViewController(), animated: true)
    }
}
