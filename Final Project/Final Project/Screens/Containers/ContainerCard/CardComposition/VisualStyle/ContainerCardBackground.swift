//
//  ContainerCardBackground.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainerCardBackground: View {
    let isRunning: Bool
    let stateColor: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DS.Radius.md)
                .fill(DS.Color.bg2)

            if isRunning {
                GeometryReader { g in
                    Ellipse()
                        .fill(
                            RadialGradient(
                                colors: [stateColor.opacity(0.06), Color.clear],
                                center: .center,
                                startRadius: 0,
                                endRadius: 60
                            )
                        )
                        .frame(width: 120, height: 80)
                        .offset(x: g.size.width - 60, y: -20)
                }
                .clipped()
            }
        }
    }
}
