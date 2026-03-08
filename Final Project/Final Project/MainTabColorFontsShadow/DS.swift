//
//  DS.swift
//  Final Project
//
//  Created by SabinaKarimli on 03.03.26.
//


import SwiftUI
import UIKit

enum DS {
    typealias Token    = DSToken
    typealias Color    = DSColor
    typealias UIColor  = DSUIKitColor
    typealias Gradient = DSGradient
    typealias Font     = DSFont
    typealias Space    = DSSpace
    typealias Radius   = DSRadius
    typealias Anim     = DSAnim
    typealias Shadow   = DSShadow
}


extension UIColor {
    convenience init(hex: String) {
        var h = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        if h.count == 6 { h += "FF" }

        var val: UInt64 = 0
        Scanner(string: h).scanHexInt64(&val)

        self.init(
            red:   CGFloat((val & 0xFF000000) >> 24) / 255,
            green: CGFloat((val & 0x00FF0000) >> 16) / 255,
            blue:  CGFloat((val & 0x0000FF00) >>  8) / 255,
            alpha: CGFloat( val & 0x000000FF)        / 255
        )
    }
}



extension Color {
    init(hex: String) {
        var h = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        if h.count == 6 { h += "FF" }

        var val: UInt64 = 0
        Scanner(string: h).scanHexInt64(&val)

        self.init(
            .sRGB,
            red:     Double((val & 0xFF000000) >> 24) / 255,
            green:   Double((val & 0x00FF0000) >> 16) / 255,
            blue:    Double((val & 0x0000FF00) >>  8) / 255,
            opacity: Double( val & 0x000000FF)        / 255
        )
    }
}
