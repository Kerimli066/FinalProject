//
//  TerminalLineNumber.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct TerminalLineNumber: View {
    let number: Int

    var body: some View {
        Text(String(format: "%5d", number))
            .font(.system(size: 10, weight: .medium, design: .monospaced))
            .foregroundColor(DS.Color.textMuted.opacity(0.55))
            .frame(width: 40, alignment: .trailing)
            .padding(.leading, 6)
            .padding(.trailing, 4)
    }
}
