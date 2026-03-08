//
//  SettingsViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {

    // MARK: - Published

    @Published var notificationsEnabled: Bool = true {
        didSet { scheduleAutoSave() }
    }

    @Published private(set) var recipientEmail:  String = ""
    @Published private(set) var isEmailVerified: Bool   = false

    @Published var cpuThreshold: Double {
        didSet {
            guard oldValue != cpuThreshold else { return }
            let clamped = min(max(cpuThreshold, 1.0), 99.0)
            if cpuThreshold != clamped {
                cpuThreshold = clamped
                return
            }
            LocalThresholdStore.saveCPU(clamped)
            AlertSeverityHelper.Threshold.current = clamped
        }
    }

    @Published var isLoading:          Bool    = false
    @Published var isSaving:           Bool    = false
    @Published var showSavedToast:     Bool    = false
    @Published var showError:          Bool    = false
    @Published var showSignOutConfirm: Bool    = false
    @Published var errorMessage:       String? = nil

    @Published private(set) var connectionStatusText:  String = "---"
    @Published private(set) var connectionStatusColor: Color  = DS.Color.textSecondary

    private let service:        LumenService
    private var autoSaveTask:   Task<Void, Never>?
    private var statusObserver: NSObjectProtocol?
    private var didLoadOnce = false

    init(service: LumenService = AppEnvironment.makeLumenService()) {
        self.service = service

        let saved = LocalThresholdStore.loadCPU(default: AlertSeverityHelper.Threshold.cpuHigh)
        self.cpuThreshold = saved
        AlertSeverityHelper.Threshold.current = saved

        statusObserver = NotificationCenter.default.addObserver(
            forName: .serverConfigDidChange,
            object:  nil,
            queue:   .main
        ) { [weak self] _ in
            Task { @MainActor [weak self] in self?.updateConnectionStatus() }
        }
    }

    deinit {
        autoSaveTask?.cancel()
        if let obs = statusObserver {
            NotificationCenter.default.removeObserver(obs)
        }
    }

    // MARK: - onAppear

    func onAppear() {
        updateConnectionStatus()
        Task { [weak self] in
            await self?.loadFirebaseUser()
            await self?.loadSettings()
        }
    }

    // MARK: - Firebase User

    private func loadFirebaseUser() async {
        guard let user = Auth.auth().currentUser else { return }

        recipientEmail  = user.email ?? ""
        isEmailVerified = user.isEmailVerified

        try? await user.reload()

        if let refreshed = Auth.auth().currentUser {
            recipientEmail  = refreshed.email ?? ""
            isEmailVerified = refreshed.isEmailVerified
        }
    }

    // MARK: - Connection Status

    func updateConnectionStatus() {
        if AppConfig.useMock {
            connectionStatusText  = "Demo"
            connectionStatusColor = DS.Color.warning
        } else if ServerConfig.shared.isConfigured {
            connectionStatusText  = "Connected"
            connectionStatusColor = DS.Color.success
        } else {
            connectionStatusText  = "Not Set"
            connectionStatusColor = DS.Color.danger
        }
    }

    // MARK: - Load Settings

    private func loadSettings() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let s = try await service.getAlertSettings()
            notificationsEnabled = s.notificationsEnabled

            if recipientEmail.isEmpty,
               let backendEmail = s.recipientEmail,
               !backendEmail.isEmpty {
                recipientEmail = backendEmail
            }

            didLoadOnce = true
        } catch {
            didLoadOnce = true
        }
    }

    // MARK: - Save Settings

    func saveSettings(showToast: Bool = true) async {
        isSaving     = true
        errorMessage = nil
        showError    = false

        let settings = AlertSettings(
            recipientEmail:       recipientEmail.isEmpty ? nil : recipientEmail,
            notificationsEnabled: notificationsEnabled
        )

        do {
            try await service.updateAlertSettings(settings)
            if showToast { showSavedToast = true }
        } catch {
            errorMessage = error.localizedDescription
            showError    = true
        }
        isSaving = false
    }

    // MARK: - Sign Out

    func signOut(from vc: UIViewController) {
        do {
            try AuthService.shared.signOut()
            ServerConfig.shared.invalidatePing()
            AppRouter.routeToAuth(from: vc)
        } catch {
            errorMessage = error.localizedDescription
            showError    = true
        }
    }

    // MARK: - Auto-Save

    private func scheduleAutoSave() {
        guard didLoadOnce else { return }
        autoSaveTask?.cancel()
        autoSaveTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 550_000_000)
            guard !Task.isCancelled else { return }
            await self?.saveSettings(showToast: false)
        }
    }
}
