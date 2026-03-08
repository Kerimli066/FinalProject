import UIKit
import SnapKit

final class OnboardingContentBuilder {

    unowned let owner: OnboardingViewController

    init(owner: OnboardingViewController) {
        self.owner = owner
    }

    func build() {
        buildImageCard()
        buildTexts()
        buildDots()
        buildActionButton()
        addViews()
        makeConstraints()
    }

    private func buildImageCard() {
        owner.imageCard.backgroundColor    = AppTheme.Color.backgroundCard
        owner.imageCard.layer.cornerRadius = AppTheme.Radius.card
        
        owner.imageCard.layer.shadowColor = UIColor.black.cgColor
        owner.imageCard.layer.shadowOpacity = 0.15
        owner.imageCard.layer.shadowRadius = 22
        owner.imageCard.layer.shadowOffset = CGSize(width: 0, height: 12)
        owner.imageCard.layer.borderWidth  = 1
        owner.imageCard.layer.borderColor  = AppTheme.Color.strokeLight.cgColor
        owner.imageCard.clipsToBounds      = false
        AppTheme.Shadow.card(on: owner.imageCard.layer)

        owner.glowLayer.colors     = [UIColor.clear.cgColor, UIColor.clear.cgColor]
        owner.glowLayer.startPoint = CGPoint(x: 0.5, y: 0)
        owner.glowLayer.endPoint   = CGPoint(x: 0.5, y: 1)
        owner.imageCard.layer.addSublayer(owner.glowLayer)

        owner.imageView.contentMode        = .scaleAspectFill
        owner.imageView.clipsToBounds      = true
        owner.imageView.layer.cornerRadius = AppTheme.Radius.card
        owner.imageCard.addSubview(owner.imageView)
        owner.imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    private func buildTexts() {
        owner.titleLabel.font = AppTheme.Font.heavy(26)
        owner.titleLabel.textColor     = AppTheme.Color.textPrimary
        owner.titleLabel.numberOfLines = 0
        owner.titleLabel.textAlignment = .center

        owner.descLabel.font          = AppTheme.Font.regular(16)
        owner.descLabel.textColor     = AppTheme.Color.textSecondary
        owner.descLabel.numberOfLines = 0
        owner.descLabel.textAlignment = .center
    }

    private func buildDots() {
        owner.dotsStack.axis      = .horizontal
        owner.dotsStack.spacing   = 8
        owner.dotsStack.alignment = .center

        for _ in 0..<3 {
            let d = UIView()
            d.backgroundColor    = AppTheme.Color.backgroundField
            d.layer.cornerRadius = 4
            owner.dotsStack.addArrangedSubview(d)
            d.snp.makeConstraints { make in
                make.height.equalTo(8)
                let width = make.width.equalTo(8).constraint
                owner.dotWidthConstraints.append(width)
            }
            owner.dotViews.append(d)
        }
    }

    private func buildActionButton() {
        owner.actionButton.setTitle("Next", for: .normal)
        owner.actionButton.setTitleColor(.white, for: .normal)
        owner.actionButton.titleLabel?.font   = AppTheme.Font.bold(18)
        owner.actionButton.backgroundColor    = AppTheme.Color.accent
        owner.actionButton.layer.cornerRadius = 28

        let arrowSym = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        owner.arrowImg.image       = UIImage(systemName: "arrow.right.circle.fill", withConfiguration: arrowSym)
        owner.arrowImg.tintColor   = UIColor.white.withAlphaComponent(0.72)
        owner.arrowImg.contentMode = .scaleAspectFit
        owner.actionButton.addSubview(owner.arrowImg)
        owner.arrowImg.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(26)
        }

        owner.actionButton.addTarget(
            owner,
            action: #selector(OnboardingViewController.tappedAction),
            for: .touchUpInside
        )
    }

    private func addViews() {
        owner.view.addSubview(owner.ambientGlow)
        owner.view.addSubview(owner.imageCard)
        owner.view.addSubview(owner.titleLabel)
        owner.view.addSubview(owner.descLabel)
        owner.view.addSubview(owner.dotsStack)
        owner.view.addSubview(owner.actionButton)
    }

    private func makeConstraints() {
        guard let topBar = owner.backButton.superview else { return }

        owner.imageCard.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.88)
            $0.height.equalTo(owner.imageCard.snp.width).multipliedBy(0.72)
        }
        owner.ambientGlow.snp.makeConstraints {
            $0.center.equalTo(owner.imageCard)
            $0.width.equalTo(owner.imageCard.snp.width).multipliedBy(0.92)
            $0.height.equalTo(owner.imageCard.snp.height).multipliedBy(0.82)
        }

        owner.titleLabel.snp.makeConstraints {
            $0.top.equalTo(owner.imageCard.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(28)
        }

        owner.descLabel.snp.makeConstraints {
            $0.top.equalTo(owner.titleLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(36)
        }

        owner.dotsStack.snp.makeConstraints {
            $0.bottom.equalTo(owner.actionButton.snp.top).offset(-28)
            $0.centerX.equalToSuperview()
        }

        owner.actionButton.snp.makeConstraints {
            $0.bottom.equalTo(owner.view.safeAreaLayoutGuide).inset(28)
            $0.left.right.equalToSuperview().inset(28)
            $0.height.equalTo(64)
        }
    }
}
