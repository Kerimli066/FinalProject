import UIKit

final class LoginViewModel {

    enum Route { case goRegister, goForgot, finished(isNewUser: Bool) }

    var onLoading:          ((Bool) -> Void)?
    var onError:            ((String) -> Void)?
    var onRoute:            ((Route) -> Void)?
    var onEmailNotVerified: ((String, @escaping () -> Void) -> Void)?

    // MARK: - Login

    func login(email: String, password: String) {
        let e = email.trimmingCharacters(in: .whitespacesAndNewlines)

        if e.isEmpty {
            onError?("Please enter your email address."); return
        }
        if !e.contains("@") {
            onError?("Email must include '@' — e.g. name@gmail.com"); return
        }
        if password.isEmpty {
            onError?("Please enter your password."); return
        }

        Task { [weak self] in
            guard let self else { return }
            await MainActor.run { self.onLoading?(true) }
            do {
                try await AuthService.shared.login(email: e, password: password)
                await MainActor.run {
                    self.onLoading?(false)
                    self.onRoute?(.finished(isNewUser: false))
                }
            } catch {
                
                let msg = LoginViewModel.firebaseError(error)
                await MainActor.run { [weak self] in
                    self?.onLoading?(false)
                    if let ae = error as? AuthError, ae == .emailNotVerified {
                        self?.onEmailNotVerified?(e, {
                            Task { try? await AuthService.shared.resendVerification() }
                        })
                    } else {
                        self?.onError?(msg)
                    }
                }
            }
        }
    }

    // MARK: - Google

    func signInWithGoogle(from vc: UIViewController) {
        Task { [weak self] in
            guard let self else { return }
            await MainActor.run { self.onLoading?(true) }
            do {
                let isNew = try await AuthService.shared.signInWithGoogle(presentingVC: vc)
                await MainActor.run {
                    self.onLoading?(false)
                    self.onRoute?(.finished(isNewUser: isNew))
                }
            } catch {
                let msg = LoginViewModel.firebaseError(error)
                await MainActor.run { [weak self] in
                    self?.onLoading?(false)
                    self?.onError?(msg)
                }
            }
        }
    }

    // MARK: - GitHub

    func signInWithGithub() {
        Task { [weak self] in
            guard let self else { return }
            await MainActor.run { self.onLoading?(true) }
            do {
                let isNew = try await AuthService.shared.signInWithGitHub()
                await MainActor.run {
                    self.onLoading?(false)
                    self.onRoute?(.finished(isNewUser: isNew))
                }
            } catch {
                let msg = LoginViewModel.firebaseError(error)
                await MainActor.run { [weak self] in
                    self?.onLoading?(false)
                    self?.onError?(msg)
                }
            }
        }
    }

    func goRegister() { onRoute?(.goRegister) }
    func goForgot()   { onRoute?(.goForgot) }


    private static func firebaseError(_ error: Error) -> String {
        let code = (error as NSError).code
        switch code {
        case 17004, 17009:
            return "Incorrect email or password. Please try again."
        case 17008:
            return "Invalid email address format."
        case 17010:
            return "Too many attempts. Please wait and try again."
        case 17020:
            return "Network error. Please check your internet connection."
        case 17011:
            return "No account found with this email. Please sign up first."
        default:
            return error.localizedDescription
        }
    }
}
