//
//  CircularProgress.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import SwiftUI

struct CircularProgress: View {
    let progress:  Double
    let color:     Color
    var size:      CGFloat  = 54
    var lineWidth: CGFloat  = 5
    var label:     String?  = nil
    var sublabel:  String?  = nil

    var body: some View {
        ZStack {
            Circle()
                .stroke(DS.Color.bg4, lineWidth: lineWidth)
                .frame(width: size, height: size)
            Circle()
                .trim(from: 0, to: CGFloat(min(max(progress, 0), 1)))
                .stroke(
                    color,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .frame(width: size, height: size)
                .rotationEffect(.degrees(-90))
                .shadow(color: color.opacity(0.45), radius: 5)
                .animation(DS.Anim.smooth, value: progress)
            if let lbl = label {
                VStack(spacing: 1) {
                    Text(lbl)
                        .font(.system(size: size > 48 ? 12 : 10, weight: .bold, design: .rounded))
                        .foregroundColor(color)
                    if let sub = sublabel {
                        Text(sub)
                            .font(.system(size: 8, weight: .medium))
                            .foregroundColor(DS.Color.textTertiary)
                    }
                }
            }
        }
    }
}


