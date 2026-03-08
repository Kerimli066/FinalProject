//
//  OnboardingStepPresenter.swift
//  Final Project
//
//  Created by SabinaKarimli on 07.03.26.
//

import UIKit

final class OnboardingStepPresenter {

    unowned let owner: OnboardingViewController
    private lazy var toneStyler = OnboardingToneStyler(owner: owner)

    init(owner: OnboardingViewController) {
        self.owner = owner
    }

    func applyText(step: OnboardingStep) {
        switch step {
        case .monitor:
            owner.titleLabel.text = "Monitor Your\nInfrastructure\nAnywhere"
            owner.descLabel.text = "Track container logs and system health in real time, right from your phone."

        case .logs:
            owner.titleLabel.text = "Live Container\nLogs"
            owner.descLabel.text = "Real-time log streaming with color-coded severity levels for instant debugging."

        case .alerts:
            owner.titleLabel.text = "Smart Alerts &\nSystem Health"
            owner.descLabel.text = "Stay ahead of downtime with real-time notifications and metrics for your Docker containers."
        }
    }

    func applyStep(step: OnboardingStep, animated: Bool) {
        let tone = step.accentColor

        owner.stepLabel.text = "STEP \(step.rawValue + 1) OF 3"
        owner.actionButton.setTitle(step == .alerts ? "Get Started" : "Next", for: .normal)
        owner.backButton.alpha = step == .monitor ? 0 : 1
        owner.backButton.isEnabled = step != .monitor

        if animated {
            owner.transitionAnimator.performTransition(to: step, tone: tone)
        } else {
            owner.imageView.image = UIImage(named: "onboarding\(step.rawValue + 1)")
            applyText(step: step)

            toneStyler.applyToneColor(tone)
            toneStyler.applyGlow(tone: tone)
            toneStyler.applyDots(activeIndex: step.rawValue, tone: tone, animated: false)
            owner.ambientGlow.applyTone(tone, animated: false)
        }
    }
}
