//
//  ContainerCardNameBlock.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainerCardNameBlock: View {
    let name: String
    let image: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(name)
                .font(DS.Font.headline(14))
                .foregroundColor(DS.Color.textPrimary)
                .lineLimit(1)

            Text(image)
                .font(DS.Font.mono(10))
                .foregroundColor(DS.Color.textMuted)
                .lineLimit(1)
        }
    }
}
