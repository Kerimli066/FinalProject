//
//  ServerCardView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct ServerCardView: View {
    let appeared: Bool
    @Binding var showServerSetup: Bool

    let connectionColor: Color
    let connectionText: String

    var body: some View {
        GlowCardView(accent: DS.Color.accent) {
            CardHeaderView(title: "SERVER", icon: "server.rack", color: DS.Color.accent)

            VStack(spacing: 0) {
                ServerRowView(
                    icon: "server.rack",
                    iconColor: DS.Color.accent,
                    title: PrettyHostFormatter.prettyHost(from: AppConfig.baseURL),
                    subtitle: "REST + WebSocket endpoint",
                    badge: nil,
                    badgeColor: .clear
                )

                ThinDividerView()

                ServerRowView(
                    icon: "dot.radiowaves.left.and.right",
                    iconColor: connectionColor,
                    title: "Connection Status",
                    subtitle: AppConfig.useMock ? "Mock / Demo data active" : "Live server data",
                    badge: connectionText.uppercased(),
                    badgeColor: connectionColor
                )

                ThinDividerView()

                ServerRowView(
                    icon: "slider.horizontal.3",
                    iconColor: AppConfig.useMock ? DS.Color.warning : DS.Color.success,
                    title: "Data Mode",
                    subtitle: "Source of all container data",
                    badge: AppConfig.useMock ? "MOCK" : "LIVE",
                    badgeColor: AppConfig.useMock ? DS.Color.warning : DS.Color.success
                )

                ThinDividerView()

                ChangeServerButtonView(onTap: { showServerSetup = true })
                    .padding(.top, 16)
            }
            .padding(.bottom, 4)
        }
    }
}



