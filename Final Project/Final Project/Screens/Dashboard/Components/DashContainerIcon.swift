//
//  DashContainerIcon.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI


struct DashContainerIcon: View {
    let image: String
    let color: Color
    var size:  CGFloat = 36

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.28)
                .fill(color.opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.28)
                        .stroke(color.opacity(0.25), lineWidth: 1)
                )
                .frame(width: size, height: size)
            Image(systemName: sysIcon)
                .font(.system(size: size * 0.42, weight: .semibold))
                .foregroundColor(color)
        }
    }

    private var sysIcon: String {
        let l = image.lowercased()
        if l.contains("postgres") || l.contains("mysql")  { return "cylinder.fill" }
        if l.contains("mongo")                            { return "cylinder.split.1x2.fill" }
        if l.contains("redis")                            { return "memorychip.fill" }
        if l.contains("nginx")                            { return "network" }
        if l.contains("python")                           { return "chevron.left.forwardslash.chevron.right" }
        if l.contains("minio")                            { return "externaldrive.fill.badge.plus" }
        if l.contains("alpine") || l.contains("busybox") { return "terminal.fill" }
        if l.contains("lumen")                            { return "bolt.fill" }
        return "shippingbox.fill"
    }
}
