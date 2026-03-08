import UIKit

final class OnboardingToneStyler {

    unowned let owner: OnboardingViewController

    init(owner: OnboardingViewController) {
        self.owner = owner
    }

    func applyToneColor(_ tone: UIColor) {
        UIView.animate(
            withDuration: 0.30,
            delay: 0,
            options: [.allowUserInteraction, .beginFromCurrentState]
        ) {
            self.owner.stepLabel.textColor          = tone
            self.owner.actionButton.backgroundColor = tone
        }
        let shadowAnim                  = CABasicAnimation(keyPath: "shadowColor")
        shadowAnim.fromValue            = owner.actionButton.layer.shadowColor
        shadowAnim.toValue              = tone.cgColor
        shadowAnim.duration             = 0.35
        shadowAnim.timingFunction       = CAMediaTimingFunction(name: .easeInEaseOut)
        shadowAnim.fillMode             = .forwards
        shadowAnim.isRemovedOnCompletion = false
        owner.actionButton.layer.add(shadowAnim, forKey: "shadowColorAnim")

        owner.actionButton.layer.shadowColor   = tone.cgColor
        owner.actionButton.layer.shadowOpacity = 0.55
        owner.actionButton.layer.shadowRadius  = 24
        owner.actionButton.layer.shadowOffset  = CGSize(width: 0, height: 10)
        let borderAnim                  = CABasicAnimation(keyPath: "borderColor")
        borderAnim.fromValue            = owner.imageCard.layer.borderColor
        borderAnim.toValue              = tone.withAlphaComponent(0.35).cgColor
        borderAnim.duration             = 0.35
        borderAnim.timingFunction       = CAMediaTimingFunction(name: .easeInEaseOut)
        borderAnim.fillMode             = .forwards
        borderAnim.isRemovedOnCompletion = false
        owner.imageCard.layer.add(borderAnim, forKey: "borderColorAnim")
        owner.imageCard.layer.borderColor = tone.withAlphaComponent(0.35).cgColor
    }

    func applyGlow(tone: UIColor) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.35)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
        owner.glowLayer.colors = [
            tone.withAlphaComponent(0).cgColor,
            tone.withAlphaComponent(0.28).cgColor
        ]
        CATransaction.commit()
        let cardShadow                  = CABasicAnimation(keyPath: "shadowColor")
        cardShadow.fromValue            = owner.imageCard.layer.shadowColor
        cardShadow.toValue              = tone.cgColor
        cardShadow.duration             = 0.35
        cardShadow.timingFunction       = CAMediaTimingFunction(name: .easeInEaseOut)
        cardShadow.fillMode             = .forwards
        cardShadow.isRemovedOnCompletion = false
        owner.imageCard.layer.add(cardShadow, forKey: "cardShadowAnim")
        owner.imageCard.layer.shadowColor   = tone.cgColor
        owner.imageCard.layer.shadowOpacity = 0.22
        owner.imageCard.layer.shadowRadius  = 28
        owner.imageCard.layer.shadowOffset  = CGSize(width: 0, height: 12)
    }

    func animateCardPulse() {

        let shadowAnim = CABasicAnimation(keyPath: "shadowRadius")
        shadowAnim.fromValue = owner.imageCard.layer.shadowRadius
        shadowAnim.toValue = 32
        shadowAnim.duration = 0.25
        shadowAnim.autoreverses = true
        shadowAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        owner.imageCard.layer.add(shadowAnim, forKey: "shadowPulse")

        UIView.animate(
            withDuration: 0.16,
            delay: 0,
            options: [.curveEaseOut]
        ) {
            self.owner.imageCard.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        } completion: { _ in
            UIView.animate(
                withDuration: 0.40,
                delay: 0,
                usingSpringWithDamping: 0.82,
                initialSpringVelocity: 0.1
            ) {
                self.owner.imageCard.transform = .identity
            }
        }
    }

    func applyDots(activeIndex: Int, tone: UIColor, animated: Bool) {
        let changes = {
            for i in 0..<self.owner.dotViews.count {
                let active = (i == activeIndex)
                self.owner.dotViews[i].backgroundColor = active
                    ? tone
                    : AppTheme.Color.backgroundField
                self.owner.dotWidthConstraints[i].update(offset: active ? 22 : 8)
                self.owner.dotViews[i].layer.shadowColor   = active ? tone.cgColor : UIColor.clear.cgColor
                self.owner.dotViews[i].layer.shadowOpacity = active ? 0.60 : 0
                self.owner.dotViews[i].layer.shadowRadius  = active ? 6 : 0
                self.owner.dotViews[i].layer.shadowOffset  = .zero
            }
            self.owner.view.layoutIfNeeded()
        }

        if animated {
            UIView.animate(
                withDuration: 0.36,
                delay: 0,
                usingSpringWithDamping: 0.82,
                initialSpringVelocity: 0.1,
                options: [.allowUserInteraction, .beginFromCurrentState],
                animations: changes
            )
        } else {
            changes()
        }
    }
}
