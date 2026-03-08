//
//  ChangeServerButtonView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI


struct ChangeServerButtonView: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 11)
                        .fill(DS.Color.accent.opacity(0.15))
                        .frame(width: 40, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 11)
                                .stroke(DS.Color.accent.opacity(0.3), lineWidth: 1)
                        )

                    Image(systemName: "pencil.and.list.clipboard")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(DS.Color.accent)
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text("Change Server URL")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(DS.Color.accent)

                    Text(PrettyHostFormatter.prettyHost(from: AppConfig.baseURL))
                        .font(.system(size: 12, weight: .regular, design: .monospaced))
                        .foregroundColor(DS.Color.textTertiary)
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: "arrow.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(DS.Color.accent.opacity(0.6))
            }
        }
        .buttonStyle(.plain)
    }
}
