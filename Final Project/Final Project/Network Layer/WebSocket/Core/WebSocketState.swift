//
//  WebSocketState.swift
//  Final Project
//
//  Created by SabinaKarimli on 24.02.26.
//


import Foundation

enum WebSocketState: Equatable {
    case idle
    case connecting
    case connected
    case disconnected(reason: String)
    case failed(error: String)
}

