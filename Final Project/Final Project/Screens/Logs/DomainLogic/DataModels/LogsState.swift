//
//  LogsState.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import SwiftUI

final class LogsState: ObservableObject {
    @Published var preselected: ContainerInfo?  = nil
    @Published var containers:  [ContainerInfo] = []
}
