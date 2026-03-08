//
//  SummaryItem.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//


import SwiftUI

struct SummaryItem: Identifiable {
    let id = UUID()
    let value: String
    let label: String
    let icon: String
    let color: Color
}