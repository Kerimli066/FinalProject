//
//  HttpMethod.swift
//  Final Project
//
//  Created by SabinaKarimli on 01.02.26.
//

import Foundation

protocol NetworkClientProtocol {
    func send<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T
}

final class NetworkClient: NetworkClientProtocol {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared) {
        self.session = session

        let d = JSONDecoder()
        d.dateDecodingStrategy = DateParser.decodingStrategy
        self.decoder = d
    }

    func send<T: Decodable>(_ endpoint: Endpoint, as type: T.Type = T.self) async throws -> T {
        let request: URLRequest
        switch endpoint.makeRequest() {
        case .success(let r): request = r
        case .failure(let e): throw e
        }

        do {
            let (data, response) = try await session.data(for: request)

            guard let http = response as? HTTPURLResponse else {
                throw NetworkError.emptyResponse
            }

            guard (200...299).contains(http.statusCode) else {
                let body = data.isEmpty ? nil : String(data: data, encoding: .utf8)
                throw NetworkError.serverError(status: http.statusCode, body: body)
            }

            if T.self == EmptyResponse.self {
                if data.isEmpty { return EmptyResponse() as! T }
                if let str = String(data: data, encoding: .utf8),
                   str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return EmptyResponse() as! T
                }
                if let result = try? decoder.decode(T.self, from: data) { return result }
                return EmptyResponse() as! T
            }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }

        } catch let e as NetworkError {
            throw e
        } catch {
            throw NetworkError.underlying(error)
        }
    }
}
