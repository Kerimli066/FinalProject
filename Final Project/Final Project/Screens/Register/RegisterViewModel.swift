import UIKit

final class RegisterViewModel {

    enum Route {
        case goLogin
        case goVerify(email: String)
        case finished(isNewUser: Bool)
    }

    var onLoading: ((Bool) -> Void)?
    var onError:   ((String) -> Void)?
    var onRoute:   ((Route) -> Void)?

    // MARK: - Register

    func register(email: String, password: String, confirmPassword: String? = nil) {
        let e = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if let err = validate(email: e, password: password, confirmPassword: confirmPassword) {
            onError?(err); return
        }
        Task { [weak self] in
            guard let self else { return }
            await MainActor.run { self.onLoading?(true) }
            do {
                try await AuthService.shared.register(email: e, password: password)
                await MainActor.run { self.onLoading?(false); self.onRoute?(.goVerify(email: e)) }
            } catch {
                await MainActor.run { self.onLoading?(false); self.onError?("[AUTH] " + self.mapFirebaseError(error)) }
            }
        }
    }

    // MARK: - Social Auth

    func signInWithGoogle(from vc: UIViewController) {
        Task { [weak self] in
            guard let self else { return }
            await MainActor.run { self.onLoading?(true) }
            do {
                let isNew = try await AuthService.shared.signInWithGoogle(presentingVC: vc)
                await MainActor.run { self.onLoading?(false); self.onRoute?(.finished(isNewUser: isNew)) }
            } catch {
                await MainActor.run { self.onLoading?(false); self.onError?(self.mapFirebaseError(error)) }
            }
        }
    }

    func signInWithGithub() {
        Task { [weak self] in
            guard let self else { return }
            await MainActor.run { self.onLoading?(true) }
            do {
                let isNew = try await AuthService.shared.signInWithGitHub()
                await MainActor.run { self.onLoading?(false); self.onRoute?(.finished(isNewUser: isNew)) }
            } catch {
                await MainActor.run { self.onLoading?(false); self.onError?(self.mapFirebaseError(error)) }
            }
        }
    }

    private func validate(email: String, password: String, confirmPassword: String?) -> String? {
        if let emailError = EmailValidator.validate(email) { return emailError }

        if password.isEmpty     { return "Password is required." }
        if password.count < 8   { return "Password must be at least 8 characters." }
        if password.count > 128 { return "Password is too long. Maximum 128 characters." }

        let hasNumberOrSpecial = password.rangeOfCharacter(from: .decimalDigits) != nil
            || password.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil
        guard hasNumberOrSpecial else {
            return "Password must contain at least one number or special character."
        }

        if let confirm = confirmPassword, !confirm.isEmpty, confirm != password {
            return "Passwords do not match."
        }

        return nil
    }

    // MARK: - Firebase Error Mapping

    private func mapFirebaseError(_ error: Error) -> String {
        switch (error as NSError).code {
        case 17007: return "Account already exists for this address. Try signing in."
        case 17008: return "The address you entered is not valid."
        case 17026: return "The chosen secret is too weak. Use 8+ chars with numbers or symbols."
        case 17010: return "Too many attempts. Please wait and try again."
        case 17020: return "Network issue detected. Check your internet connection."
        default:    return error.localizedDescription
        }
    }
}
