//
//  AppEnvironment.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.03.26.
//

import Foundation

enum AppEnvironment {

    static func makeLumenService() -> LumenService {
        AppConfig.useMock
            ? MockLumenService.shared
            : RealLumenService(baseURL: AppConfig.baseURL)
    }

    static func makeStatsStreaming() -> StatsStreaming {
        AppConfig.useMock
        ? MockStatsHub.shared
            : StatsWebSocketService(baseURL: AppConfig.baseURL)
    }

    static func makeLogsStreaming() -> LogsStreaming {
        AppConfig.useMock
            ? MockLogsHub()
            : LogsWebSocketService(
                baseURL: AppConfig.baseURL,
                client: makeWebSocketClient()
            )
    }

    static func makeWebSocketClient() -> WebSocketClient {
        AppConfig.useMock
            ? MockWebSocketClient()
            : DefaultWebSocketClient()
    }
}
