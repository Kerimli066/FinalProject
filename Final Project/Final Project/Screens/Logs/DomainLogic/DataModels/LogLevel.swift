//
//  LogLevel.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import SwiftUI

enum LogLevel: String, CaseIterable {
    case all, error, warning, info, debug

    var tag: String {
        switch self {
        case .all:     return "ALL"
        case .error:   return "ERR"
        case .warning: return "WRN"
        case .info:    return "INF"
        case .debug:   return "DBG"
        }
    }

    var icon: String {
        switch self {
        case .all:     return "list.bullet"
        case .error:   return "xmark.octagon.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .info:    return "info.circle.fill"
        case .debug:   return "ladybug.fill"
        }
    }

    var color: Color {
        switch self {
        case .all:     return DS.Color.accent
        case .error:   return DS.Color.danger
        case .warning: return DS.Color.warning
        case .info:    return DS.Color.success
        case .debug:   return DS.Color.textTertiary
        }
    }

    static func detect(from line: String) -> LogLevel {
        let u = line.uppercased()

        // 1. JSON (Pino / Winston / Bunyan)
        if u.contains("\"LEVEL\":\"ERROR\"") || u.contains("\"LEVEL\":\"FATAL\"")
            || u.contains("\"LEVEL\":\"CRITICAL\"") || u.contains("\"SEVERITY\":\"ERROR\"") { return .error }
        if u.contains("\"LEVEL\":\"WARN\"") || u.contains("\"LEVEL\":\"WARNING\"")
            || u.contains("\"SEVERITY\":\"WARN\"") { return .warning }
        if u.contains("\"LEVEL\":\"DEBUG\"") || u.contains("\"LEVEL\":\"TRACE\"") { return .debug }
        if u.contains("\"LEVEL\":\"INFO\"") || u.contains("\"SEVERITY\":\"INFO\"") { return .info }

        // 2. KEY=VALUE (logfmt / Spring Cloud)
        if u.contains("LEVEL=ERROR") || u.contains("SEVERITY=ERROR") { return .error }
        if u.contains("LEVEL=WARN") || u.contains("LEVEL=WARNING")   { return .warning }
        if u.contains("LEVEL=DEBUG") || u.contains("LEVEL=TRACE")    { return .debug }
        if u.contains("LEVEL=INFO")                                   { return .info }

        // 3. Space-delimited (Logback / Java)
        if u.contains(" ERROR ") || u.contains(" FATAL ") || u.contains(" CRITICAL ") { return .error }
        if u.contains(" WARN ")  || u.contains(" WARNING ")                            { return .warning }
        if u.contains(" DEBUG ") || u.contains(" TRACE ")                              { return .debug }
        if u.contains(" INFO ")                                                         { return .info }

        // 4. Docker stderr
        if u.contains("STDERR") { return .error }

        // 5. Bracket / prefix style
        if u.contains("[ERROR]") || u.contains("[FATAL]") { return .error }
        if u.contains("[WARN]")  || u.contains("[WARNING]") { return .warning }
        if u.contains("[DEBUG]") || u.contains("[TRACE]")  { return .debug }
        if u.contains("[INFO]")                            { return .info }

        // 6. Crash / runtime keywords
        if u.contains("EXCEPTION") || u.contains("STACKTRACE") || u.contains("TRACEBACK")
            || u.contains("SEGFAULT") || u.contains("OOM") || u.contains("OUTOFMEMORY")
            || u.contains("CRASH") || u.contains("PANIC") || u.contains("ABORTED") { return .error }

        // 7. Network / retry warnings
        if u.contains("TIMEOUT") || u.contains("RETRY") || u.contains("RETRYING")
            || u.contains("DISCONNECTED") || u.contains("UNREACHABLE") { return .warning }

        // 8. HTTP status codes
        if let range = u.range(of: #" [45]\d\d "#, options: .regularExpression) {
            let code = u[range].trimmingCharacters(in: .whitespaces)
            if code.hasPrefix("5") { return .error }
            if code.hasPrefix("4") { return .warning }
        }

        return .info
    }
}
