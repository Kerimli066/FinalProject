//
//  DashInteractiveChartCanvas.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

struct DashInteractiveChartCanvas<OverlayContent: View>: View {
    let count: Int
    let minY: Double
    let maxY: Double

    let height: CGFloat
    let showXAxisFromTimestamps: [Date]?

    @Binding var hoveredIdx: Int?

    let overlay: (DashChartPlotArea) -> OverlayContent

    init(
        count: Int,
        minY: Double,
        maxY: Double,
        height: CGFloat,
        showXAxisFromTimestamps: [Date]? = nil,
        hoveredIdx: Binding<Int?>,
        @ViewBuilder overlay: @escaping (DashChartPlotArea) -> OverlayContent
    ) {
        self.count = count
        self.minY = minY
        self.maxY = maxY
        self.height = height
        self.showXAxisFromTimestamps = showXAxisFromTimestamps
        self._hoveredIdx = hoveredIdx
        self.overlay = overlay
    }

    var body: some View {
        GeometryReader { geo in
            let W = geo.size.width
            let H = geo.size.height

            let lp: CGFloat = 38
            let bp: CGFloat = 26
            let tp: CGFloat = 8

            let cW = W - lp
            let cH = H - bp - tp
            let step = count > 1 ? cW / CGFloat(count - 1) : cW

            let plot = DashChartPlotArea(
                W: W, H: H,
                lp: lp, bp: bp, tp: tp,
                cW: cW, cH: cH,
                step: step
            )

            ZStack(alignment: .topLeading) {
                DashChartGrid(minY: minY, maxY: maxY, plot: plot)

                if let ts = showXAxisFromTimestamps, ts.count == count, count > 1 {
                    DashChartXAxisLabels(timestamps: ts, plot: plot)
                }

                overlay(plot)
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { v in
                        guard count > 0 else { return }
                        let raw = (v.location.x - lp) / max(step, 1)
                        let idx = Int(raw.rounded())
                        hoveredIdx = max(0, min(count - 1, idx))
                    }
                    .onEnded { _ in
                        withAnimation(DashAnim.fast) { hoveredIdx = nil }
                    }
            )
        }
        .frame(height: height)
    }
}
