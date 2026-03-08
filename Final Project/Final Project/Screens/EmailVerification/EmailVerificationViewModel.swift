//
//  EmailVerificationViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 28.02.26.
//


import Foundation
import FirebaseAuth


final class EmailVerificationViewModel {


    var onVerified:       (() -> Void)?
    var onCooldownTick:   ((Int) -> Void)?
    var onCooldownEnd:    (() -> Void)?
    var onResendSuccess:  ((String) -> Void)?
    var onResendError:    ((String) -> Void)?
    var onCheckError:     ((String) -> Void)?


    private var checkTimer:    Timer?
    private var cooldownTimer: Timer?
    private(set) var cooldownSeconds = 0
    private(set) var isOnCooldown   = false


    func startAutoCheck() {
        checkTimer?.invalidate()
        checkTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            Task { await self?.silentCheck() }
        }
    }

    func stopTimers() {
        checkTimer?.invalidate()
        cooldownTimer?.invalidate()
        checkTimer    = nil
        cooldownTimer = nil
    }

    private func silentCheck() async {
        guard let user = Auth.auth().currentUser else { return }
        try? await user.reload()
        guard user.isEmailVerified else { return }
        checkTimer?.invalidate()
        await MainActor.run { [weak self] in self?.onVerified?() }
    }


    func manualCheck() async -> Bool {
        guard let user = Auth.auth().currentUser else {
            await MainActor.run { [weak self] in
                self?.onCheckError?("You are not signed in.")
            }
            return false
        }
        do {
            try await user.reload()
        } catch {
            await MainActor.run { [weak self] in
                self?.onCheckError?(self?.mapFirebaseError(error) ?? error.localizedDescription)
            }
            return false
        }
        return user.isEmailVerified
    }


    func resendVerification() async {
        guard !isOnCooldown else { return }
        do {
            try await AuthService.shared.resendVerification()
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.onResendSuccess?("A new verification link has been sent.")
                self.startCooldown(60)
            }
        } catch {
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.onResendError?(self.mapFirebaseError(error))
            }
        }
    }


    private func startCooldown(_ seconds: Int) {
        cooldownSeconds = seconds
        isOnCooldown    = true
        cooldownTimer?.invalidate()
        cooldownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.cooldownSeconds -= 1
            self.onCooldownTick?(self.cooldownSeconds)
            if self.cooldownSeconds <= 0 {
                self.cooldownTimer?.invalidate()
                self.isOnCooldown = false
                self.onCooldownEnd?()
            }
        }
    }


    private func mapFirebaseError(_ error: Error) -> String {
        let code = (error as NSError).code
        switch code {
        case 17010: return "Too many requests. Please wait a minute and try again."
        case 17011: return "This account has been deleted."
        case 17020: return "Network error. Please check your internet connection."
        case 17999: return "An internal error occurred. Please try again."
        default:    return error.localizedDescription
        }
    }
}
