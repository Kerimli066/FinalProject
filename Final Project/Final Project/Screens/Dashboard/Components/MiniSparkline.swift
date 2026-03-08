//
//  MiniSparkline.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct MiniSparkline: View {
    let values: [Double]
    let color:  Color

    var body: some View {
        GeometryReader { geo in
            if values.count > 1 {
                let w    = geo.size.width
                let h    = geo.size.height
                let minV = values.min() ?? 0
                let maxV = max(values.max() ?? 1, minV + 1)
                let step = w / CGFloat(values.count - 1)

                ZStack {
                    Path { p in
                        let pts = values.enumerated().map { i, v in
                            CGPoint(x: CGFloat(i) * step,
                                    y: h - CGFloat((v - minV) / (maxV - minV)) * h)
                        }
                        guard let first = pts.first else { return }
                        p.move(to: CGPoint(x: first.x, y: h))
                        p.addLine(to: first)
                        pts.dropFirst().forEach { p.addLine(to: $0) }
                        p.addLine(to: CGPoint(x: pts.last!.x, y: h))
                        p.closeSubpath()
                    }
                    .fill(LinearGradient(
                        colors: [color.opacity(0.3), .clear],
                        startPoint: .top, endPoint: .bottom
                    ))

                    Path { p in
                        for (i, v) in values.enumerated() {
                            let pt = CGPoint(
                                x: CGFloat(i) * step,
                                y: h - CGFloat((v - minV) / (maxV - minV)) * h
                            )
                            i == 0 ? p.move(to: pt) : p.addLine(to: pt)
                        }
                    }
                    .stroke(color, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
                    .shadow(color: color.opacity(0.5), radius: 3)
                }
            }
        }
    }
}
