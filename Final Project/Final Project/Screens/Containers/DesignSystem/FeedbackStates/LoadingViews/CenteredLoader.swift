//
//  CenteredLoader.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct CenteredLoader: View {
    let message: String

    var body: some View {
        VStack {
            Spacer()
            LumenLoadingView(message: message)
            Spacer()
        }
    }
}

