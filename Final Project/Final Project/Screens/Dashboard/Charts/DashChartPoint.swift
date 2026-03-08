//
//  DashChartPoint.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import Foundation

struct DashChartPoint: Identifiable {
    let id        = UUID()
    let timestamp: Date
    let value:     Double
}
