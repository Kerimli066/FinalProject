//
//  EnvVarCell.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct EnvVarCell: View {
    let key:   String
    let value: String
    @State private var revealed = false

    private var isSensitive: Bool {
        let k = key.lowercased()
        return ["password","secret","token","key","pwd","pass","auth","api_key","private","credential"]
            .contains(where: { k.contains($0) })
    }

    private var displayValue: String {
        if isSensitive && !revealed { return "•••••••••••••" }
        let v = value.lowercased()
        if v.hasPrefix("postgresql://") || v.hasPrefix("redis://") || v.hasPrefix("mysql://") {
            guard let at = value.range(of: "@") else { return value }
            return String(value[..<at.lowerBound].prefix(12)) + "***@" + String(value[at.upperBound...])
        }
        return value
    }

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(key)
                .font(DS.Font.monoSemibold(11))
                .foregroundColor(DS.Color.accent)
                .frame(minWidth: 80, alignment: .leading)
                .lineLimit(2)
            Text(displayValue)
                .font(DS.Font.mono(11))
                .foregroundColor(isSensitive && !revealed
                                 ? DS.Color.textTertiary : DS.Color.textSecondary)
                .lineLimit(3)
                .textSelection(.enabled)
            Spacer()
            if isSensitive {
                Button {
                    withAnimation(DS.Anim.fast) { revealed.toggle() }
                } label: {
                    Image(systemName: revealed ? "eye.slash" : "eye")
                        .font(.system(size: 12))
                        .foregroundColor(DS.Color.textTertiary)
                }
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: DS.Radius.xs)
                .fill(DS.Color.bg3)
                .overlay(RoundedRectangle(cornerRadius: DS.Radius.xs)
                    .stroke(isSensitive ? DS.Color.warning.opacity(0.18) : DS.Color.cardBorder, lineWidth: 1))
        )
    }
}

