//
//  LogsStreaming.swift
//  Final Project
//
//  Created by SabinaKarimli on 14.02.26.
//

import Foundation

protocol LogsStreaming {
    func stream(containerId: String) -> AsyncThrowingStream<LogLine, Error>
}

