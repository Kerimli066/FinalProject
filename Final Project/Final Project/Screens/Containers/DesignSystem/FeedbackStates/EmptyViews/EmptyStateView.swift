//
//  EmptyStateView.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct EmptyStateView: View {
    let icon:    String
    let title:   String
    let message: String
    var color:   Color = DS.Color.textTertiary

    var body: some View {
        VStack(spacing: DS.Space.sm) {
            ZStack {
                Circle().fill(DS.Color.bg3).frame(width: 80, height: 80)
                Circle().stroke(color.opacity(0.12), lineWidth: 1).frame(width: 80, height: 80)
                Image(systemName: icon)
                    .font(.system(size: 28, weight: .light))
                    .foregroundColor(color.opacity(0.5))
            }
            Text(title)
                .font(DS.Font.headline(16))
                .foregroundColor(DS.Color.textSecondary)
            Text(message)
                .font(DS.Font.caption(13))
                .foregroundColor(DS.Color.textTertiary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, DS.Space.xl)
        }
    }
}


