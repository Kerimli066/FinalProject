//
//  AuthService.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

final class AuthService {

    static let shared = AuthService()
    private init() {}

    var currentUser: User? { Auth.auth().currentUser }
    var isSignedIn:  Bool  { Auth.auth().currentUser != nil }

    // MARK: Sign Out

    func signOut() throws {
        GIDSignIn.sharedInstance.signOut()
        try Auth.auth().signOut()
    }

    // MARK: Register

    func register(email: String, password: String) async throws {
        _ = try await Auth.auth().createUser(withEmail: email, password: password)
        try await resendVerification()
    }

    // MARK: Login

    func login(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        try await result.user.reload()
        guard result.user.isEmailVerified else {
            try? Auth.auth().signOut()
            throw AuthError.emailNotVerified
        }
    }

    // MARK: Resend Verification

    func resendVerification() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.notSignedIn
        }
        try await withCheckedThrowingContinuation { (cont: CheckedContinuation<Void, Error>) in
            user.sendEmailVerification { error in
                if let error = error { cont.resume(throwing: error) }
                else { cont.resume() }
            }
        }
    }

    // MARK: Password Reset

    func sendPasswordReset(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    // MARK: Google Sign-In

    func signInWithGoogle(presentingVC: UIViewController) async throws -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw AuthError.missingClientID
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)

        let result: GIDSignInResult = try await withCheckedThrowingContinuation { cont in
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
                if let error = error { cont.resume(throwing: error); return }
                guard let result = result else {
                    cont.resume(throwing: AuthError.missingGoogleToken); return
                }
                cont.resume(returning: result)
            }
        }

        guard let idToken = result.user.idToken?.tokenString else {
            throw AuthError.missingGoogleToken
        }
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: result.user.accessToken.tokenString
        )
        let authResult = try await Auth.auth().signIn(with: credential)
        return authResult.additionalUserInfo?.isNewUser ?? false
    }

    // MARK: GitHub Sign-In

    func signInWithGitHub() async throws -> Bool {
        let provider = OAuthProvider(providerID: "github.com")
        let credential: AuthCredential = try await withCheckedThrowingContinuation { cont in
            provider.getCredentialWith(nil) { credential, error in
                if let error = error { cont.resume(throwing: error); return }
                guard let credential = credential else {
                    cont.resume(throwing: AuthError.githubCredentialMissing); return
                }
                cont.resume(returning: credential)
            }
        }
        let authResult = try await Auth.auth().signIn(with: credential)
        return authResult.additionalUserInfo?.isNewUser ?? false
    }
}
