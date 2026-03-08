//
//  ProAlertRowFooter.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import SwiftUI

struct ProAlertRowFooter: View {
    let sevColor: Color
    let isCPU: Bool
    let valueStr: String
    let timestamp: Date

    var body: some View {
        HStack {
            ProAlertRowMetricPill(sevColor: sevColor, isCPU: isCPU, valueStr: valueStr)
            Spacer()
            ProAlertRowTime(timestamp: timestamp)
        }
    }
}