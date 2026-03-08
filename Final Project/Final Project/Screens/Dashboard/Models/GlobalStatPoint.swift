//
//  GlobalStatPoint.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//

import Foundation


struct GlobalStatPoint: Identifiable {
    let id             = UUID()
    let timestamp:     Date
    let totalCPU:      Double
    let totalMemoryMB: Double
}
