//
//  DSFont.swift
//  Final Project
//
//  Created by SabinaKarimli on 05.03.26.
//


import SwiftUI

enum DSFont {
    static func display(_ size: CGFloat = 32) -> SwiftUI.Font { .system(size: size, weight: .heavy, design: .rounded) }
    static func title(_ size: CGFloat = 22) -> SwiftUI.Font   { .system(size: size, weight: .bold, design: .rounded) }
    static func headline(_ size: CGFloat = 15) -> SwiftUI.Font{ .system(size: size, weight: .semibold, design: .default) }
    static func body(_ size: CGFloat = 14) -> SwiftUI.Font    { .system(size: size, weight: .regular, design: .default) }
    static func caption(_ size: CGFloat = 12) -> SwiftUI.Font { .system(size: size, weight: .medium, design: .default) }
    static func label(_ size: CGFloat = 10) -> SwiftUI.Font   { .system(size: size, weight: .semibold, design: .default) }
    static func mono(_ size: CGFloat = 12) -> SwiftUI.Font    { .system(size: size, weight: .regular, design: .monospaced) }
    static func monoSemibold(_ size: CGFloat = 12) -> SwiftUI.Font { .system(size: size, weight: .semibold, design: .monospaced) }
}