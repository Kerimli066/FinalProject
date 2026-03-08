//
//  PlaceholderViewController.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import UIKit

final class PlaceholderViewController: UIViewController {

    private let labelText: String

    private let label: UILabel = {
        let l = UILabel()
        l.font          = .systemFont(ofSize: 17, weight: .semibold)
        l.textColor     = DS.UIColor.textTertiary
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()

    init(label: String) {
        self.labelText = label
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DS.UIColor.bg0
        label.text = "\(labelText)\nComing Soon"

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }
}
