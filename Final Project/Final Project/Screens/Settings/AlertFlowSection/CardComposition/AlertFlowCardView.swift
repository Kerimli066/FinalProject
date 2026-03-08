//
//  AlertFlowCardView.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI

struct AlertFlowCardView: View {
    let appeared: Bool

    var body: some View {
        GlowCardView(accent: DS.Color.success) {
            CardHeaderView(title: "ALERT FLOW", icon: "arrow.triangle.branch", color: DS.Color.success)

            HStack(spacing: 0) {
                FlowNodeView(icon: "waveform", label: "Stream", color: DS.Color.accent, appeared: appeared, delay: 0.0)
                FlowConnectorView()
                FlowNodeView(icon: "exclamationmark.triangle.fill", label: "Breach", color: DS.Color.warning, appeared: appeared, delay: 0.1)
                FlowConnectorView()
                FlowNodeView(icon: "list.clipboard.fill", label: "Record", color: DS.Color.success, appeared: appeared, delay: 0.2)
                FlowConnectorView()
                FlowNodeView(icon: "envelope.badge.fill", label: "Notify", color: DS.Color.accentSoft, appeared: appeared, delay: 0.3)
            }
            .padding(.vertical, 4)
        }
    }
}



