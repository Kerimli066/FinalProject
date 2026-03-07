//
//  SectionDivider.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.03.26.
//

import UIKit
final class SectionDivider: UIView {

    init(text: String = "OR CONTINUE WITH") {
        super.init(frame: .zero)
        let label = UILabel()
        label.text      = text
        label.font      = AppTheme.Font.bold(10)
        label.textColor = AppTheme.Color.textMuted

        let left  = lineView()
        let right = lineView()

        addSubview(left)
        addSubview(label)
        addSubview(right)

        label.snp.makeConstraints { $0.center.equalToSuperview() }
        left.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.right.equalTo(label.snp.left).offset(-10)
            $0.height.equalTo(1)
        }
        right.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
            $0.left.equalTo(label.snp.right).offset(10)
            $0.height.equalTo(1)
        }
        snp.makeConstraints { $0.height.equalTo(20) }
    }

    required init?(coder: NSCoder) { fatalError() }

    private func lineView() -> UIView {
        let v = UIView()
        v.backgroundColor = AppTheme.Color.stroke
        return v
    }
}
