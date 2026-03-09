import UIKit
import SnapKit

final class OnboardingViewControllerUIHelper {

    unowned let owner: OnboardingViewController

    private lazy var topBarBuilder = OnboardingTopBarBuilder(owner: owner)
    private lazy var contentBuilder = OnboardingContentBuilder(owner: owner)
    private lazy var stepPresenter = OnboardingStepPresenter(owner: owner)

    init(owner: OnboardingViewController) {
        self.owner = owner
    }

    func buildUI() {
        owner.view.insertSubview(owner.gradient, at: 0)
        owner.gradient.snp.makeConstraints { $0.edges.equalToSuperview() }

        topBarBuilder.build()
        contentBuilder.build()
    }

    func applyText(step: OnboardingStep) {
        stepPresenter.applyText(step: step)
    }

    func applyStep(step: OnboardingStep, animated: Bool) {
        stepPresenter.applyStep(step: step, animated: animated)
    }
}
