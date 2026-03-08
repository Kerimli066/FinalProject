import Foundation

final class ForgotViewModel {
    var onLoading: ((Bool) -> Void)?
    var onError:   ((String) -> Void)?
    var onSent:    ((String) -> Void)?

    func send(email: String) {
        let e = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !e.isEmpty else { onError?("Please enter your email."); return }
        Task { [weak self] in
            guard let self else { return }
            await MainActor.run { self.onLoading?(true) }
            do {
                try await AuthService.shared.sendPasswordReset(email: e)
                await MainActor.run { self.onLoading?(false); self.onSent?(e) }
            } catch {
                await MainActor.run { self.onLoading?(false); self.onError?(error.localizedDescription) }
            }
        }
    }
}
