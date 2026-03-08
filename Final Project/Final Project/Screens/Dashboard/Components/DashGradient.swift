//
//  DashGradient.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//



import SwiftUI

enum DashGradient {
    static let pageBackground                      = DS.Gradient.pageBG
    static let cpuCard                             = DS.Gradient.cpuCard
    static let memCard                             = DS.Gradient.memCard
    static let runCard                             = DS.Gradient.success
    static let critCard                            = DS.Gradient.danger
    static func healthGlow(_ c: Color)             -> RadialGradient { DS.Gradient.healthGlow(c) }
    static func healthGlow(_ s: HealthStatus)      -> RadialGradient { DS.Gradient.healthGlow(s.color) }
}

