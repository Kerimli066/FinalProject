//
//  AppInfoCardView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct AppInfoCardView: View {

    private let version: String = {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
    }()

    private let build: String = {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "—"
    }()

    private let platform: String = {
        "iOS \(UIDevice.current.systemVersion)"
    }()

    var body: some View {
        GlowCardView(accent: DS.Color.textTertiary.opacity(0.4)) {
            CardHeaderView(title: "APPLICATION", icon: "info.circle.fill", color: DS.Color.textTertiary)

            VStack(spacing: 0) {
                AppRowView(label: "Version",  value: version)
                ThinDividerView()
                AppRowView(label: "Platform", value: platform)
                ThinDividerView()
                AppRowView(label: "Build",    value: build)
                ThinDividerView()
                AppRowView(label: "API",      value: "v1.0.0")
            }
            .padding(.bottom, 4)
        }
    }
}
