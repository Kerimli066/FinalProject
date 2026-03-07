//
//  PremiumNavDelegate.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import UIKit
final class PremiumNavDelegate: NSObject, UINavigationControllerDelegate {

    static let shared = PremiumNavDelegate()
    private override init() { super.init() }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        PremiumPushAnimator(isPush: operation == .push)
    }
}


