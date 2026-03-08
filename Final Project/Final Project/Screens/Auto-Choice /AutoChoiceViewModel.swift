//
//  AutoChoiceViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 21.02.26.
//

import Foundation

final class AutoChoiceViewModel {
    var navigateToLogin:    (() -> Void)?
    var navigateToRegister: (() -> Void)?

    func signInTapped()        { navigateToLogin?() }
    func createAccountTapped() { navigateToRegister?() }
}
