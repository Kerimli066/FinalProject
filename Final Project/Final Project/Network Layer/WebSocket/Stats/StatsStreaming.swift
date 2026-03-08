//
//  StatsStreaming.swift
//  Final Project
//
//  Created by SabinaKarimli on 13.02.26.
//


import Foundation

protocol StatsStreaming {
    func stream(containerId: String, email: String?) -> AsyncThrowingStream<ContainerStats, Error>
}

