//
//  OnboardingViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 27.01.26.
//

import Foundation
final class OnboardingViewModel {
    var currentStep: OnboardingStep = .monitor
    var onStepChanged: ((OnboardingStep) -> Void)?
    var onFinish: (() -> Void)?

    func handleAction() {
        if currentStep == .alerts { onFinish?() }
        else if let next = OnboardingStep(rawValue: currentStep.rawValue + 1) { goTo(next) }
    }
    func goTo(_ step: OnboardingStep) { currentStep = step; onStepChanged?(step) }
    func skip() { onFinish?() }
}
