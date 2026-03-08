//
//  PremiumVolumeRow.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct PremiumVolumeRow: View {
    let volume: DockerVolume
    let index: Int
    
    private var isAnonymous: Bool { volume.Name.count > 40 }
    
    private var displayName: String {
        isAnonymous ? String(volume.Name.prefix(16)) + "…" : volume.Name
    }
    
    private var pathSegments: [String] {
        volume.Mountpoint.split(separator: "/").map(String.init)
    }
    
    private var accent: Color { DS.Color.warning }
    
    var body: some View {
        PremiumRowShell(index: index, accent: accent) {
            PremiumIconBox(
                accent: accent,
                systemName: isAnonymous ? "externaldrive" : "externaldrive.fill",
                glow: false
            )
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(displayName)
                        .font(DS.Font.headline(13))
                        .foregroundColor(DS.Color.textPrimary)
                        .lineLimit(1)
                    
                    if isAnonymous {
                        PillView.muted("anon", font: DS.Font.label(8), paddingH: 5, paddingV: 2)
                    }
                }
                
                HStack(spacing: 3) {
                    let tail = Array(pathSegments.suffix(3))
                    ForEach(Array(tail.enumerated()), id: \.offset) { i, seg in
                        if i > 0 {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 7))
                                .foregroundColor(DS.Color.textMuted)
                        }
                        
                        Text(seg)
                            .font(DS.Font.mono(9))
                            .foregroundColor(
                                i == tail.count - 1
                                ? DS.Color.accent.opacity(0.8)
                                : DS.Color.textMuted
                            )
                    }
                }
            }
            
            Spacer()
            
            // SONRA:
            VStack(alignment: .trailing, spacing: 4) {
                Text(volume.Driver)
                    .font(DS.Font.mono(10))
                    .foregroundColor(DS.Color.textSecondary)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(DS.Color.bg4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(DS.Color.cardBorder, lineWidth: 1)
                            )
                    )
            }
        }
    }
}
