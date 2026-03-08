//
//  PremiumImageRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct PremiumImageRow: View {
    let image: DockerImage
    let index: Int
    let maxSize: Int64

    private var name: String {
        guard let t = image.RepoTags?.first, !t.isEmpty else { return "<none>" }
        return t.split(separator: ":").first.map(String.init) ?? t
    }

    private var tag: String {
        guard let t = image.RepoTags?.first else { return "latest" }
        let p = t.split(separator: ":")
        return p.count > 1 ? String(p[1]) : "latest"
    }

    private var sizeStr: String {
        guard let s = image.Size else { return "—" }
        return s > 1_000_000_000
            ? String(format: "%.1f GB", Double(s) / 1_000_000_000)
            : String(format: "%.0f MB", Double(s) / 1_000_000)
    }

    private var createdStr: String { RelativeTime.abbrev(unixSeconds: image.Created) }

    private var sizeRatio: Double {
        guard let s = image.Size, maxSize > 0 else { return 0 }
        return Double(s) / Double(maxSize)
    }

    private var inUse: Bool { (image.Containers ?? 0) > 0 }

    private var sizeColor: Color {
        sizeRatio > 0.7 ? DS.Color.warning : sizeRatio > 0.4 ? DS.Color.accentSoft : DS.Color.success
    }

    private var imageAccentColor: Color {
        let l = name.lowercased()
        if l.contains("lumen")    { return DS.Color.accent }
        if l.contains("postgres") { return DS.Color.accentSoft }
        if l.contains("redis")    { return DS.Color.danger }
        if l.contains("mongo")    { return DS.Color.warning }
        if l.contains("nginx")    { return DS.Color.success }
        if l.contains("python")   { return DS.Color.accentSoft }
        if l.contains("minio")    { return DS.Color.warning }
        return DS.Color.textTertiary
    }

    var body: some View {
        PremiumRowShell(index: index, accent: imageAccentColor) {
            PremiumIconBox(
                accent: imageAccentColor,
                systemName: "square.stack.3d.up.fill",
                glow: false
            )

            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(DS.Font.headline(13))
                    .foregroundColor(DS.Color.textPrimary)
                    .lineLimit(1)

                HStack(spacing: 5) {
                    PillView.tag(tag)

                    if inUse {
                        PillView.success("in use", icon: "checkmark.circle.fill")
                    }
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 5) {
                Text(sizeStr)
                    .font(DS.Font.monoSemibold(12))
                    .foregroundColor(sizeColor)

                MiniProgressBar(ratio: sizeRatio, color: sizeColor, width: 60, height: 3)

                Text(createdStr)
                    .font(DS.Font.mono(9))
                    .foregroundColor(DS.Color.textMuted)
            }
        }
    }
}
