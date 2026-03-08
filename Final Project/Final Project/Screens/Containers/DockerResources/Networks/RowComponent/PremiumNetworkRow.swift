//
//  PremiumNetworkRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct PremiumNetworkRow: View {
    let network: DockerNetwork
    let index: Int

    private var containers: Int { network.Containers?.count ?? 0 }
    private var subnet: String { network.IPAM?.Config?.first?.Subnet ?? "—" }

    private var driverColor: Color {
        switch network.Driver?.lowercased() {
        case "bridge":  return DS.Color.accent
        case "host":    return DS.Color.warning
        case "overlay": return DS.Color.success
        case "null":    return DS.Color.textTertiary
        case "macvlan": return DS.Color.accentSoft
        default:        return DS.Color.textTertiary
        }
    }

    private var scopeLabel: String { (network.Scope ?? "local").capitalized }

    private var networkIcon: String {
        switch network.Driver?.lowercased() {
        case "bridge":  return "network"
        case "host":    return "desktopcomputer"
        case "overlay": return "square.3.layers.3d"
        case "null":    return "network.slash"
        case "macvlan": return "antenna.radiowaves.left.and.right"
        default:        return "network"
        }
    }

    var body: some View {
        PremiumRowShell(index: index, accent: driverColor) {
            PremiumIconBox(
                accent: driverColor,
                systemName: networkIcon,
                glow: containers > 0
            )

            VStack(alignment: .leading, spacing: 4) {
                Text(network.Name ?? "—")
                    .font(DS.Font.headline(13))
                    .foregroundColor(DS.Color.textPrimary)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    PillView.driver(network.Driver ?? "—", color: driverColor)
                    PillView.muted(scopeLabel)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 5) {
                InlineInfoRow(
                    icon: "dot.radiowaves.left.and.right",
                    iconSize: 8,
                    iconColor: DS.Color.textMuted,
                    text: subnet,
                    textFont: DS.Font.mono(10),
                    textColor: DS.Color.textSecondary
                )

                HStack(spacing: 4) {
                    if containers > 0 { PulseDot(color: driverColor, size: 4) }
                    else { Circle().fill(DS.Color.textMuted).frame(width: 4, height: 4) }

                    Text("\(containers)")
                        .font(DS.Font.monoSemibold(11))
                        .foregroundColor(containers > 0 ? driverColor : DS.Color.textMuted)

                    Text("ctr")
                        .font(DS.Font.mono(9))
                        .foregroundColor(DS.Color.textMuted)
                }
            }
        }
    }
}
