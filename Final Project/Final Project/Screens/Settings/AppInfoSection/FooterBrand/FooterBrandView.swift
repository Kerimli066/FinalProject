//
//  FooterBrandView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct FooterBrandView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer().frame(height: 8)

            FooterBrandIcon()

            FooterBrandTexts()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 12)
    }
}



