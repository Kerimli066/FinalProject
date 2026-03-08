//
//  ContainerDetailSections.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct ContainerDetailSections: View {
    let envVars: [(key: String, value: String)]
    let ports: [String]
    let mounts: [String]

    @Binding var envExpanded: Bool
    @Binding var portsExpanded: Bool
    @Binding var mountsExpanded: Bool

    var body: some View {
        Group {
            if !envVars.isEmpty {
                AccordionSection(
                    title: "Environment",
                    icon: "key.horizontal",
                    iconColor: DS.Color.accent,
                    count: envVars.count,
                    isExpanded: $envExpanded
                ) {
                    ForEach(envVars, id: \.key) { pair in
                        EnvVarCell(key: pair.key, value: pair.value)
                    }
                }
            }

            if !ports.isEmpty {
                AccordionSection(
                    title: "Port Mappings",
                    icon: "network",
                    iconColor: DS.Color.accentSoft,
                    count: ports.count,
                    isExpanded: $portsExpanded
                ) {
                    ForEach(ports, id: \.self) { port in
                        InfoCell(icon: "arrow.left.arrow.right", color: DS.Color.accent, text: port)
                    }
                }
            }

            if !mounts.isEmpty {
                AccordionSection(
                    title: "Volume Mounts",
                    icon: "externaldrive",
                    iconColor: DS.Color.warning,
                    count: mounts.count,
                    isExpanded: $mountsExpanded
                ) {
                    ForEach(mounts, id: \.self) { mount in
                        InfoCell(icon: "folder.fill", color: DS.Color.warning, text: mount)
                    }
                }
            }
        }
    }
}