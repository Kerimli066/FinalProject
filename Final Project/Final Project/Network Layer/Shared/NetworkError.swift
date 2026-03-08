//
//  NetworkError.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.02.26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case emptyResponse
    case serverError(status: Int, body: String?)
    case encodingError(Error)
    case decodingError(Error)
    case underlying(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .emptyResponse:
            return "Empty response"
        case .serverError(let status, let body):
            return "Server error \(status): \(body ?? "No body")"
        case .encodingError(let e):
            return "Request encoding failed: \(e.localizedDescription)"
        case .decodingError(let e):
            return "Response decoding failed: \(e.localizedDescription)"
        case .underlying(let e):
            return "Transport error: \(e.localizedDescription)"
        }
    }
}
