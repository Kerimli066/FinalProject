//
//  ServerConfig.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//

import Foundation
import Security

extension Notification.Name {
    static let serverConfigDidChange = Notification.Name("pocketlumen.serverConfig.didChange")
}

final class ServerConfig {

    static let shared = ServerConfig()
    private init() {}

    private let urlKeychainKey      = "pocketlumen.serverURL.v1"
    private let pingVerifiedKey     = "pocketlumen.pingVerified.v1"
    private let fallbackURL         = "http://159.223.192.61:8324"

    // MARK: - URL (Keychain)

    var baseURL: String {
        get { keychainRead(key: urlKeychainKey) ?? fallbackURL }
        set { keychainWrite(key: urlKeychainKey, value: newValue); notifyChange() }
    }

    // MARK: - Ping Verified (Keychain)

    var pingVerified: Bool {
        get { keychainRead(key: pingVerifiedKey) == "true" }
        set {
            newValue
                ? keychainWrite(key: pingVerifiedKey, value: "true")
                : keychainDelete(key: pingVerifiedKey)
            notifyChange()
        }
    }

    // MARK: - isConfigured

    var isConfigured: Bool {
        keychainRead(key: urlKeychainKey) != nil && pingVerified
    }

    // MARK: - Helpers

    func invalidatePing() {
        pingVerified = false
    }

    func reset() {
        keychainDelete(key: urlKeychainKey)
        keychainDelete(key: pingVerifiedKey)
        notifyChange()
    }

    // MARK: - Notification

    private func notifyChange() {
        NotificationCenter.default.post(name: .serverConfigDidChange, object: nil)
    }

    // MARK: - Keychain

    private func keychainWrite(key: String, value: String) {
        let data = Data(value.utf8)
        let query: [CFString: Any] = [
            kSecClass:       kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData:   data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    private func keychainRead(key: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass:       kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData:  true,
            kSecMatchLimit:  kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess,
              let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    private func keychainDelete(key: String) {
        let query: [CFString: Any] = [
            kSecClass:       kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
