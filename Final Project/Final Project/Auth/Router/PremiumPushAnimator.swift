//
//  PremiumPushAnimator.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.03.26.
//

import UIKit

final class PremiumPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private let isPush: Bool
    init(isPush: Bool) { self.isPush = isPush }

    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval { 0.55 }

    func animateTransition(using ctx: UIViewControllerContextTransitioning) {
        guard
            let fromVC = ctx.viewController(forKey: .from),
            let toVC   = ctx.viewController(forKey: .to)
        else { ctx.completeTransition(false); return }

        let container = ctx.containerView
        let toView    = ctx.view(forKey: .to)   ?? toVC.view!
        let fromView  = ctx.view(forKey: .from) ?? fromVC.view!
        let duration  = transitionDuration(using: ctx)

        if isPush {
            container.addSubview(toView)
            ScreenAnimator.navPush(toView: toView, fromView: fromView, duration: duration) { _ in
                ctx.completeTransition(!ctx.transitionWasCancelled)
            }
        } else {
            container.insertSubview(toView, belowSubview: fromView)
            ScreenAnimator.navPop(toView: toView, fromView: fromView, duration: duration) { _ in
                ctx.completeTransition(!ctx.transitionWasCancelled)
            }
        }
    }
}
