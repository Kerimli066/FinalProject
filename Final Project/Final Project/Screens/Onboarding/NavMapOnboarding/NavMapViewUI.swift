import UIKit
import SnapKit

final class NavMapViewUI {

    let navScrollView = UIScrollView()
    let contentStack = UIStackView()
    let startButton = PrimaryButton(title: "Start Exploring")
    var moduleCards: [UIView] = []

    private let modules: [(icon: String, title: String, sub: String, desc: String, color: UIColor)] = [
        ("gauge.with.dots.needle.67percent", "Smart Dashboard", "CENTRAL INTELLIGENCE",
         "Unified operational view with telemetry, health snapshots and real-time charts.",
         UIColor(hex: "#3D5AFE")),
        ("shippingbox.fill", "Container Hub", "CONTAINER CONTROL",
         "Browse all Docker containers, inspect details and control lifecycle actions.",
         UIColor(hex: "#06B6D4")),
        ("terminal.fill", "Stream Logs", "EVENT INSPECTOR",
         "Live container logs with real-time streaming, search and instant filtering.",
         UIColor(hex: "#8B5CF6")),
        ("bell.badge.fill", "Intelligent Alerts", "THRESHOLD NOTIFIER",
         "CPU/Memory alert history and notifications when thresholds are exceeded.",
         UIColor(hex: "#10B981")),
        ("waveform.path.ecg", "Live Logs", "REAL-TIME STREAM",
         "Stream container output instantly with auto-scroll and level-based filtering.",
         UIColor(hex: "#3B82F6")),
        ("slider.horizontal.3", "Core Settings", "CONFIGURATION",
         "Manage notifications, alerts, backend connection and app preferences.",
         UIColor(hex: "#6366F1"))
    ]

    func build(in view: UIView, target: NavMapViewController) {
        buildBackground(in: view)

        let badge = makeBadge()
        let titleLbl = UILabel()
        titleLbl.text = "Your Command\nCenter Awaits"
        titleLbl.font = AppTheme.Font.heavy(36)
        titleLbl.textColor = AppTheme.Color.textPrimary
        titleLbl.numberOfLines = 2
        titleLbl.textAlignment = .center

        let accentLine = makeAccentUnderline()

        let subLbl = UILabel()
        subLbl.text = "Explore every module below.\nTap Get Started when you're ready."
        subLbl.font = AppTheme.Font.regular(15)
        subLbl.textColor = AppTheme.Color.textSecondary
        subLbl.numberOfLines = 0
        subLbl.textAlignment = .center

        let headerStack = UIStackView(arrangedSubviews: [badge, titleLbl, accentLine, subLbl])
        headerStack.axis = .vertical
        headerStack.spacing = 12
        headerStack.alignment = .center
        headerStack.setCustomSpacing(8, after: titleLbl)
        headerStack.setCustomSpacing(14, after: accentLine)

        contentStack.axis = .vertical
        contentStack.spacing = 14
        contentStack.alignment = .fill

        modules.forEach { m in
            let card = buildCard(
                icon: m.icon,
                title: m.title,
                sub: m.sub,
                desc: m.desc,
                color: m.color
            )
            moduleCards.append(card)
            contentStack.addArrangedSubview(card)
            card.alpha = 0
            card.transform = CGAffineTransform(translationX: 0, y: 36).scaledBy(x: 0.94, y: 0.94)
        }

        navScrollView.showsVerticalScrollIndicator = false
        navScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)

        let wrapStack = UIStackView(arrangedSubviews: [headerStack, contentStack])
        wrapStack.axis = .vertical
        wrapStack.spacing = 28
        wrapStack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        wrapStack.isLayoutMarginsRelativeArrangement = true

        navScrollView.addSubview(wrapStack)
        view.addSubview(navScrollView)
        view.addSubview(startButton)

        startButton.alpha = 0
        startButton.transform = CGAffineTransform(translationX: 0, y: 20)
        startButton.addTarget(target, action: #selector(target.tappedStart), for: .touchUpInside)

        startButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(22)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(64)
        }
        navScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(startButton.snp.top).offset(-12)
        }
        wrapStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }

    private func buildBackground(in view: UIView) {
        let grad = GradientView()
        view.insertSubview(grad, at: 0)
        grad.snp.makeConstraints { $0.edges.equalToSuperview() }

        let gridHost = UIView()
        gridHost.alpha = 0.055
        view.insertSubview(gridHost, at: 1)
        gridHost.snp.makeConstraints { $0.edges.equalToSuperview() }

        let step: CGFloat = 42
        let w = UIScreen.main.bounds.width
        let h: CGFloat = 3200
        let path = UIBezierPath()

        stride(from: CGFloat(0), through: w + step, by: step).forEach { x in
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: h))
        }
        stride(from: CGFloat(0), through: h, by: step).forEach { y in
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: w, y: y))
        }

        let gridLayer = CAShapeLayer()
        gridLayer.path = path.cgPath
        gridLayer.strokeColor = AppTheme.Color.accent.cgColor
        gridLayer.lineWidth = 0.6
        gridHost.layer.addSublayer(gridLayer)
    }

    private func makeBadge() -> UIView {
        let wrap = UIView()
        wrap.backgroundColor = AppTheme.Color.accent.withAlphaComponent(0.12)
        wrap.layer.cornerRadius = 12
        wrap.layer.borderWidth = 1
        wrap.layer.borderColor = AppTheme.Color.accent.withAlphaComponent(0.35).cgColor

        let lbl = UILabel()
        lbl.text = "✦  POCKET LUMEN"
        lbl.font = AppTheme.Font.bold(11)
        lbl.textColor = AppTheme.Color.accent

        wrap.addSubview(lbl)
        lbl.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 14, bottom: 6, right: 14))
        }
        return wrap
    }

    private func makeAccentUnderline() -> UIView {
        let line = UIView()
        line.backgroundColor = AppTheme.Color.accent
        line.layer.cornerRadius = 1.5
        line.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.width.equalTo(60)
        }

        let glow = CALayer()
        glow.frame = CGRect(x: -6, y: -4, width: 72, height: 11)
        glow.backgroundColor = AppTheme.Color.accent.withAlphaComponent(0.35).cgColor
        glow.cornerRadius = 5.5
        line.layer.insertSublayer(glow, at: 0)

        return line
    }

    private func buildCard(icon: String, title: String, sub: String, desc: String, color: UIColor) -> UIView {
        let card = UIView()
        card.backgroundColor = AppTheme.Color.backgroundCard
        card.layer.cornerRadius = AppTheme.Radius.card
        card.layer.borderWidth = 1
        card.layer.borderColor = color.withAlphaComponent(0.22).cgColor
        AppTheme.Shadow.colored(color, on: card.layer)

        let iconWrap = UIView()
        iconWrap.backgroundColor = color.withAlphaComponent(0.13)
        iconWrap.layer.cornerRadius = 16
        iconWrap.layer.borderWidth = 1
        iconWrap.layer.borderColor = color.withAlphaComponent(0.3).cgColor

        let iconGrad = CAGradientLayer()
        iconGrad.colors = [
            color.withAlphaComponent(0.35).cgColor,
            color.withAlphaComponent(0.08).cgColor
        ]
        iconGrad.startPoint = CGPoint(x: 0, y: 0)
        iconGrad.endPoint = CGPoint(x: 1, y: 1)
        iconGrad.cornerRadius = 16
        iconWrap.layer.insertSublayer(iconGrad, at: 0)

        let iconSym = UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold)
        let iconImg = UIImageView(image: UIImage(systemName: icon, withConfiguration: iconSym))
        iconImg.tintColor = color
        iconImg.contentMode = .scaleAspectFit
        iconWrap.addSubview(iconImg)

        let tagWrap = UIView()
        tagWrap.backgroundColor = color.withAlphaComponent(0.10)
        tagWrap.layer.cornerRadius = 6

        let tagLbl = UILabel()
        tagLbl.text = sub
        tagLbl.font = AppTheme.Font.bold(9)
        tagLbl.textColor = color
        tagWrap.addSubview(tagLbl)

        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = AppTheme.Font.bold(18)
        titleLbl.textColor = AppTheme.Color.textPrimary

        let descLbl = UILabel()
        descLbl.text = desc
        descLbl.font = AppTheme.Font.regular(13)
        descLbl.textColor = AppTheme.Color.textSecondary
        descLbl.numberOfLines = 2

        let chevSym = UIImage.SymbolConfiguration(pointSize: 11, weight: .semibold)
        let chev = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: chevSym))
        chev.tintColor = color.withAlphaComponent(0.5)

        let textStack = UIStackView(arrangedSubviews: [tagWrap, titleLbl, descLbl])
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.setCustomSpacing(6, after: tagWrap)

        card.addSubview(iconWrap)
        card.addSubview(textStack)
        card.addSubview(chev)

        iconWrap.snp.makeConstraints {
            $0.left.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(58)
        }
        iconImg.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(24)
        }
        tagLbl.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8))
        }
        chev.snp.makeConstraints {
            $0.right.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
        }
        textStack.snp.makeConstraints {
            $0.left.equalTo(iconWrap.snp.right).offset(14)
            $0.right.equalTo(chev.snp.left).offset(-8)
            $0.top.bottom.equalToSuperview().inset(18)
        }

        iconWrap.layoutIfNeeded()
        iconGrad.frame = iconWrap.bounds

        return card
    }
}
