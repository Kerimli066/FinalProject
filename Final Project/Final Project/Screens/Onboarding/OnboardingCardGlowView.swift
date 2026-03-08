import UIKit

final class OnboardingCardGlowView: UIView {

    private let glowView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        backgroundColor          = .clear

        glowView.backgroundColor         = .clear
        glowView.isUserInteractionEnabled = false
        addSubview(glowView)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        glowView.frame              = bounds
        glowView.layer.cornerRadius = bounds.height / 2

        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: bounds.height / 2
        ).cgPath
    }

    func applyTone(_ color: UIColor, animated: Bool) {
        let updates = {
            self.glowView.backgroundColor = color.withAlphaComponent(0.40)
            self.layer.shadowOpacity = 0.35
            self.layer.shadowRadius = 28
            self.layer.shadowColor = color.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 12)
            self.alpha = 1
        }

        if animated {
            UIView.animate(
                withDuration: 0.30,
                delay: 0,
                options: [.curveEaseInOut, .beginFromCurrentState, .allowUserInteraction],
                animations: updates
            )
        } else {
            updates()
        }
    }

    func pulse() {
        transform = .identity
        alpha     = 1

        UIView.animate(
            withDuration: 0.16,
            delay: 0,
            options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction]
        ) {
            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            self.alpha     = 0.75
        } completion: { _ in
            UIView.animate(
                withDuration: 0.45,
                delay: 0,
                usingSpringWithDamping: 0.80,
                initialSpringVelocity: 0.1,
                options: [.curveEaseInOut, .beginFromCurrentState, .allowUserInteraction]
            ) {
                self.transform = .identity
                self.alpha     = 1
            }
        }
    }
}
