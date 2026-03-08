//
//  DSShadow.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

enum DSShadow {
    static let card  = (color: SwiftUI.Color.black.opacity(0.45), radius: CGFloat(24), x: CGFloat(0), y: CGFloat(12))
    static let glow  = (color: SwiftUI.Color.black.opacity(0.3),  radius: CGFloat(16), x: CGFloat(0), y: CGFloat(6))
    static let soft  = (color: SwiftUI.Color.black.opacity(0.2),  radius: CGFloat(8),  x: CGFloat(0), y: CGFloat(3))
}