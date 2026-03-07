//
//  AuthError.swift
//  Final Project
//
//  Created by SabinaKarimli on 10.02.26.
//

import Foundation

enum AuthError: LocalizedError {
    case notSignedIn
    case emailNotVerified
    case missingClientID
    case missingGoogleToken
    case githubCredentialMissing
    case tooManyRequests

    var errorDescription: String? {
        switch self {
        case .notSignedIn:             return "You are not signed in."
        case .emailNotVerified:        return "Please verify your email before signing in."
        case .missingClientID:         return "Google Sign-In is misconfigured."
        case .missingGoogleToken:      return "Failed to retrieve Google token."
        case .githubCredentialMissing: return "Failed to retrieve GitHub credential."
        case .tooManyRequests:         return "Too many requests. Please wait a moment and try again."
        }
    }
}
