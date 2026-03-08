//
//  DSAnim.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

enum DSAnim {
    static let spring = Animation.spring(response: 0.45, dampingFraction: 0.78)
    static let smooth = Animation.easeInOut(duration: 0.35)
    static let fast   = Animation.easeOut(duration: 0.18)
    static let slow   = Animation.easeInOut(duration: 0.65)
    static let bounce = Animation.spring(response: 0.5, dampingFraction: 0.65)
}