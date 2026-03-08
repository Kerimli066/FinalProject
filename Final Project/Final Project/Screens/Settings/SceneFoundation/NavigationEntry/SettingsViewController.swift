//
//  SettingsViewController.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import UIKit
import SwiftUI

final class SettingsViewController: BaseViewController {
    override func setupUI() {
        embedSwiftUI(SettingsView().environment(\.settingsHostVC, self))
    }
}
