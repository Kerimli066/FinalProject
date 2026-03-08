//
//  ContainerCardIconStyle.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainerCardIconStyle {
    let container: ContainerInfo
    let isSystemCritical: Bool

    var iconColor: Color {
        guard container.isRunning else { return DS.Color.textMuted }
        if isSystemCritical { return DS.Color.accent }
        return ContainerCardIconStyle.accentColor(for: container.image)
    }

    var iconSymbol: String {
        ContainerCardIconStyle.symbol(for: container.image)
    }

    static func accentColor(for image: String) -> Color {
        let l = image.lowercased()
        if l.contains("lumen")                           { return DS.Color.accent }
        if l.contains("postgres") || l.contains("mysql") { return DS.Color.accentSoft }
        if l.contains("redis")                           { return DS.Color.danger }
        if l.contains("mongo")                           { return DS.Color.warning }
        if l.contains("minio")                           { return DS.Color.warning }
        if l.contains("nginx")                           { return DS.Color.success }
        if l.contains("python")                          { return DS.Color.accentSoft }
        return DS.Color.textTertiary
    }

    static func symbol(for image: String) -> String {
        let l = image.lowercased()
        if l.contains("postgres") || l.contains("mysql") { return "cylinder.fill" }
        if l.contains("redis")                           { return "bolt.fill" }
        if l.contains("nginx")                           { return "globe" }
        if l.contains("mongo")                           { return "leaf.fill" }
        if l.contains("python")   { return "chevron.left.forwardslash.chevron.right" }
        if l.contains("minio")                           { return "externaldrive.fill" }
        if l.contains("lumen")                           { return "bolt.circle.fill" }
        if l.contains("alpine") || l.contains("ubuntu")  { return "terminal.fill" }
        return "shippingbox.fill"
    }
}
