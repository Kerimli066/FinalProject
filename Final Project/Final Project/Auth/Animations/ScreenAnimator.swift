//
//  ScreenAnimator.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import UIKit
import SnapKit
enum ScreenAnimator {
    
    static func windowTransition(window: UIWindow, to vc: UIViewController) {
        window.rootViewController = vc
        window.makeKeyAndVisible()
        guard let snap = vc.view.snapshotView(afterScreenUpdates: true) else { return }
        window.addSubview(snap)
        snap.alpha = 0
        UIView.animate(withDuration: 0.30, delay: 0, options: .curveEaseInOut) {
            snap.alpha = 1
        } completion: { _ in snap.removeFromSuperview() }
    }


    static func prepareEntrance(_ views: [UIView]) {
        views.forEach {
            $0.alpha     = 0
            $0.transform = CGAffineTransform(translationX: 0, y: 28).scaledBy(x: 0.96, y: 0.96)
        }
    }

    static func runEntrance(_ views: [UIView],
                            baseDelay: TimeInterval = 0.08,
                            stagger: TimeInterval = 0.09) {
        for (i, v) in views.enumerated() {
            UIView.animate(
                withDuration: 0.56,
                delay: stagger * Double(i) + baseDelay,
                usingSpringWithDamping: 0.80,
                initialSpringVelocity: 0.3,
                options: .allowUserInteraction
            ) {
                v.alpha     = 1
                v.transform = .identity
            }
        }
    }


    static func runCardEntrance(_ views: [UIView],
                                baseDelay: TimeInterval = 0.05,
                                stagger: TimeInterval = 0.07) {
        views.forEach {
            $0.alpha     = 0
            $0.transform = CGAffineTransform(translationX: 0, y: 36).scaledBy(x: 0.94, y: 0.94)
        }
        for (i, v) in views.enumerated() {
            UIView.animate(
                withDuration: 0.55,
                delay: stagger * Double(i) + baseDelay,
                usingSpringWithDamping: 0.76,
                initialSpringVelocity: 0.4,
                options: .allowUserInteraction
            ) {
                v.alpha     = 1
                v.transform = .identity
            }
        }
    }


    static func splashLogoEntrance(_ logoWrap: UIView, badge: UIView,
                                   completion: @escaping () -> Void) {
        UIView.animate(
            withDuration: 1.0, delay: 0.2,
            usingSpringWithDamping: 0.55, initialSpringVelocity: 1.2,
            options: .allowUserInteraction
        ) {
            logoWrap.alpha = 1
            badge.alpha    = 1
        } completion: { _ in completion() }
    }

    static func splashItemsEntrance(_ views: [UIView],
                                    onLastComplete: @escaping () -> Void) {
        for (i, item) in views.enumerated() {
            UIView.animate(withDuration: 0.7, delay: Double(i) * 0.06 + 0.5) {
                item.alpha = 1
            } completion: { _ in
                if i == views.count - 1 { onLastComplete() }
            }
        }
    }

    static func splashProgress(_ fill: UIView, width: CGFloat, layoutParent: UIView) {
        fill.snp.updateConstraints { $0.width.equalTo(width) }
        UIView.animate(withDuration: 0.08) { layoutParent.layoutIfNeeded() }
    }

    static func splashFinish(statusLabel: UILabel,
                             progressFill: UIView,
                             pctLabel: UILabel,
                             successColor: UIColor) {
        UIView.transition(with: statusLabel, duration: 0.4, options: .transitionCrossDissolve) {
            statusLabel.text      = "DOCKER ENGINE CONNECTED ✓"
            statusLabel.textColor = successColor
        }
        UIView.animate(withDuration: 0.4) {
            progressFill.backgroundColor = successColor
            pctLabel.textColor           = successColor
        }
    }


    static func startGearRotation(_ view: UIView) {
        let rot         = CABasicAnimation(keyPath: "transform.rotation.z")
        rot.toValue     = Double.pi * 2
        rot.duration    = 3.5
        rot.repeatCount = .infinity
        view.layer.add(rot, forKey: "gearRotation")
    }


    static func startLogoPulse(_ view: UIView) {
        let pulse          = CABasicAnimation(keyPath: "transform.scale")
        pulse.toValue      = 1.07
        pulse.duration     = 1.6
        pulse.autoreverses = true
        pulse.repeatCount  = .infinity
        view.layer.add(pulse, forKey: "logoPulse")
    }


    static func onboardingTransition(outViews: [UIView],
                                     inViews: [UIView],
                                     direction: CGFloat = 1,
                                     midAction: (() -> Void)? = nil,
                                     completion: (() -> Void)? = nil) {
        let outX = -52 * direction
        let inX  =  52 * direction

        UIView.animate(withDuration: 0.20, delay: 0.0, options: .curveEaseIn) {
            outViews.forEach {
                $0.alpha     = 0
                $0.transform = CGAffineTransform(translationX: outX, y: 0).scaledBy(x: 0.95, y: 0.95)
            }
        } completion: { _ in
            midAction?()
            inViews.forEach {
                $0.alpha     = 0
                $0.transform = CGAffineTransform(translationX: -inX, y: 0).scaledBy(x: 0.95, y: 0.95)
            }
            completion?()
            UIView.animate(
                withDuration: 0.52, delay: 0,
                usingSpringWithDamping: 0.82, initialSpringVelocity: 0.35,
                options: .allowUserInteraction
            ) {
                inViews.forEach { $0.alpha = 1; $0.transform = .identity }
            }
        }
    }


    static func imageCardTransition(card: UIView,
                                    direction: CGFloat = 1,
                                    updateContent: @escaping () -> Void) {
        UIView.animate(withDuration: 0.22, delay: 0.0, options: .curveEaseIn) {
            card.transform = CGAffineTransform(translationX: -80 * direction, y: 0).scaledBy(x: 0.93, y: 0.93)
            card.alpha     = 0
        } completion: { _ in
            updateContent()
            card.transform = CGAffineTransform(translationX: 80 * direction, y: 0).scaledBy(x: 0.93, y: 0.93)
            UIView.animate(
                withDuration: 0.58, delay: 0,
                usingSpringWithDamping: 0.78, initialSpringVelocity: 0.4,
                options: .allowUserInteraction
            ) {
                card.transform = .identity
                card.alpha     = 1
            }
        }
    }


    static func navPush(toView: UIView, fromView: UIView,
                        duration: TimeInterval,
                        completion: @escaping (Bool) -> Void) {
        toView.alpha     = 0
        toView.transform = CGAffineTransform(translationX: 40, y: 0).scaledBy(x: 0.97, y: 0.97)
        UIView.animate(
            withDuration: duration, delay: 0,
            usingSpringWithDamping: 0.90, initialSpringVelocity: 0.4,
            options: [.curveEaseOut, .allowUserInteraction]
        ) {
            toView.alpha       = 1
            toView.transform   = .identity
            fromView.alpha     = 0.6
            fromView.transform = CGAffineTransform(translationX: -30, y: 0).scaledBy(x: 0.97, y: 0.97)
        } completion: { done in
            fromView.transform = .identity
            fromView.alpha     = 1
            completion(done)
        }
    }

    static func navPop(toView: UIView, fromView: UIView,
                       duration: TimeInterval,
                       completion: @escaping (Bool) -> Void) {
        toView.transform = CGAffineTransform(translationX: -30, y: 0).scaledBy(x: 0.97, y: 0.97)
        toView.alpha     = 0.6
        UIView.animate(
            withDuration: duration, delay: 0,
            usingSpringWithDamping: 0.90, initialSpringVelocity: 0.4,
            options: [.curveEaseOut, .allowUserInteraction]
        ) {
            toView.alpha       = 1
            toView.transform   = .identity
            fromView.alpha     = 0
            fromView.transform = CGAffineTransform(translationX: 40, y: 0).scaledBy(x: 0.97, y: 0.97)
        } completion: { done in
            fromView.transform = .identity
            completion(done)
        }
    }


    static func pressBounce(_ view: UIView, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.12) {
            view.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        } completion: { _ in
            UIView.animate(
                withDuration: 0.30, delay: 0,
                usingSpringWithDamping: 0.65, initialSpringVelocity: 0.5
            ) {
                view.transform = .identity
            } completion: { _ in completion?() }
        }
    }


    static func scaleDown(_ view: UIView) {
        UIView.animate(withDuration: 0.10) {
            view.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }
    }

    static func scaleRestore(_ view: UIView) {
        UIView.animate(withDuration: 0.15) { view.transform = .identity }
    }


    static func shake(_ view: UIView) {
        let anim            = CAKeyframeAnimation(keyPath: "transform.translation.x")
        anim.timingFunction = CAMediaTimingFunction(name: .linear)
        anim.duration       = 0.4
        anim.values         = [-10, 10, -8, 8, -5, 5, 0]
        view.layer.add(anim, forKey: "shake")
    }


    static func fadeIn(_ view: UIView, duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: { view.alpha = 1 }) { _ in completion?() }
    }

    static func fadeOut(_ view: UIView, duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: { view.alpha = 0 }) { _ in completion?() }
    }


    static func popIn(_ view: UIView) {
        view.transform = CGAffineTransform(scaleX: 0.88, y: 0.88)
        view.alpha     = 0
        UIView.animate(
            withDuration: 0.45, delay: 0,
            usingSpringWithDamping: 0.70, initialSpringVelocity: 0.5
        ) {
            view.transform = .identity
            view.alpha     = 1
        }
    }


    static func highlight(_ view: UIView, enabled: Bool, duration: TimeInterval = 0.2) {
        UIView.animate(withDuration: duration) { view.alpha = enabled ? 1.0 : 0.35 }
    }


    static func colorTransition(_ view: UIView, to color: UIColor, duration: TimeInterval = 0.35) {
        UIView.animate(withDuration: duration) { view.backgroundColor = color }
    }


    static func glowPulse(_ view: UIView, color: UIColor) {
        view.layer.removeAnimation(forKey: "glowPulse")
        let pulse            = CABasicAnimation(keyPath: "shadowOpacity")
        pulse.fromValue      = 0.25
        pulse.toValue        = 0.70
        pulse.duration       = 1.4
        pulse.autoreverses   = true
        pulse.repeatCount    = .infinity
        pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.layer.shadowColor   = color.cgColor
        view.layer.shadowRadius  = 22
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset  = .zero
        view.layer.add(pulse, forKey: "glowPulse")
    }

    static func stopGlowPulse(_ view: UIView) {
        view.layer.removeAnimation(forKey: "glowPulse")
        view.layer.shadowOpacity = 0
    }


    static func animateDot(_ dot: UIView, active: Bool, superview: UIView) {
        UIView.animate(
            withDuration: 0.38, delay: 0,
            usingSpringWithDamping: 0.68, initialSpringVelocity: 0.5
        ) {
            dot.backgroundColor = active ? AppTheme.Color.accent : AppTheme.Color.backgroundField
            dot.snp.updateConstraints {
                $0.width.equalTo(active ? 28 : 8)
                $0.height.equalTo(8)
            }
            superview.layoutIfNeeded()
        }
    }
}
