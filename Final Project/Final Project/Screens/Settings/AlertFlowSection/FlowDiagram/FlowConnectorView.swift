//
//  FlowConnectorView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct FlowConnectorView: View {
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<3, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 1)
                    .fill(DS.Color.textTertiary.opacity(0.25))
                    .frame(width: 4, height: 2)
            }
            Image(systemName: "arrowtriangle.right.fill")
                .font(.system(size: 7))
                .foregroundColor(DS.Color.textTertiary.opacity(0.3))
        }
        .padding(.bottom, 20)
        .frame(width: 22)
    }
}
