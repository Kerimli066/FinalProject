//
//  DashProgressBar.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import SwiftUI

struct DashProgressBar: View {
    let value:  Double
    let color:  Color
    var height: CGFloat = 4

    @State private var appeared = false

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(DS.Color.bg4)
                    .frame(height: height)
                Capsule()
                    .fill(LinearGradient(
                        colors: [color.opacity(0.7), color],
                        startPoint: .leading, endPoint: .trailing
                    ))
                    .frame(
                        width: appeared ? geo.size.width * CGFloat(min(value, 1)) : 0,
                        height: height
                    )
                    .shadow(color: color.opacity(0.5), radius: 4)
                    .animation(DS.Anim.spring, value: appeared)
            }
        }
        .frame(height: height)
        .onAppear { appeared = true }
    }
}
