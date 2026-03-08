//
//  SettingsTitleView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct SettingsTitleView: View {
    let appeared: Bool

    var body: some View {
        Text("Settings")
            .font(.system(size: 46, weight: .black, design: .rounded))
            .foregroundColor(DS.Color.textPrimary)
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 18)
            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.15), value: appeared)
    }
}
