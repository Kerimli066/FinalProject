//
//  CenteredEmpty.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct CenteredEmpty: View {
    let icon: String
    let title: String
    let message: String

    var body: some View {
        VStack {
            Spacer()
            EmptyStateView(icon: icon, title: title, message: message)
            Spacer()
        }
    }
}
