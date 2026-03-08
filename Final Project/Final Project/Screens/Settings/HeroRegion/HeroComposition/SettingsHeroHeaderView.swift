//
//  SettingsHeroHeaderView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct SettingsHeroHeaderView: View {
    let appeared: Bool
    let connectionColor: Color
    let connectionText: String
    let notificationsEnabled: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            DS.Color.bg0.frame(maxWidth: .infinity).frame(height: 280)

            Ellipse()
                .fill(DS.Color.accent.opacity(0.22))
                .frame(width: 340, height: 220)
                .blur(radius: 80)
                .offset(x: 120, y: -50)

            Circle()
                .fill(DS.Color.accentSoft.opacity(0.14))
                .frame(width: 180)
                .blur(radius: 55)
                .offset(x: -30, y: 40)

            VStack(alignment: .leading, spacing: 0) {

                SettingsHeroTopRow(
                    appeared: appeared,
                    connectionColor: connectionColor,
                    connectionText: connectionText
                )

                Spacer().frame(height: 28)

                SettingsTitleView(appeared: appeared)

                SettingsSubtitleView(appeared: appeared)

                Spacer().frame(height: 20)

                SettingsStatusPillsRow(
                    appeared: appeared,
                    notificationsEnabled: notificationsEnabled
                )
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 28)

            VStack {
                Spacer()
                LinearGradient(colors: [.clear, DS.Color.bg0], startPoint: .top, endPoint: .bottom)
                    .frame(height: 40)
            }
        }
        .frame(height: 280)
        .clipped()
    }
}
