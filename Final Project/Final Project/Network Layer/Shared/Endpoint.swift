//
//  Endpoint.swift
//  Final Project
//
//  Created by SabinaKarimli on 11.02.26.
//


import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var httpBody: Encodable? { get }
}

extension Endpoint {
    func makeRequest() -> Result<URLRequest, NetworkError> {
        guard var components = URLComponents(string: baseURL) else {
            return .failure(.invalidURL)
        }

        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        if let httpBody {
            do {
                let data = try JSONEncoder().encode(AnyEncodable(httpBody))
                request.httpBody = data
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                return .failure(.encodingError(error))
            }
        }

        return .success(request)
    }
}

private struct AnyEncodable: Encodable {
    private let encodeFn: (Encoder) throws -> Void
    init(_ wrapped: Encodable) { self.encodeFn = wrapped.encode }
    func encode(to encoder: Encoder) throws { try encodeFn(encoder) }
}
