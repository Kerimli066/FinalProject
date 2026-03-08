//
//  ContainerDetailThreshold.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

enum ContainerDetailThreshold {
    static func thresholdColor(_ v: Double, thr: Double) -> Color {
        v >= thr ? DS.Color.danger : v >= thr * 0.85 ? DS.Color.warning : DS.Color.success
    }
}