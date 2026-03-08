//
//  ContainerCardNetworkCell.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainerCardNetworkCell: View {
    let stats: ContainerStats

    private var rxText: String {
        let rx = stats.networkRx
        return rx > 1024 ? String(format: "%.1fK", Double(rx) / 1024) : "\(rx)B"
    }

    private var txText: String {
        let tx = stats.networkTx
        return tx > 1024 ? String(format: "%.1fK", Double(tx) / 1024) : "\(tx)B"
    }

    var body: some View {
        VStack(spacing: 3) {
            HStack(spacing: 3) {
                Image(systemName: "arrow.down")
                    .font(.system(size: 7, weight: .bold))
                    .foregroundColor(DS.Color.success.opacity(0.7))

                Text(rxText)
                    .font(DS.Font.mono(10))
                    .foregroundColor(DS.Color.textSecondary)
            }

            HStack(spacing: 3) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 7, weight: .bold))
                    .foregroundColor(DS.Color.accentSoft.opacity(0.7))

                Text(txText)
                    .font(DS.Font.mono(10))
                    .foregroundColor(DS.Color.textSecondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 9)
    }
}
