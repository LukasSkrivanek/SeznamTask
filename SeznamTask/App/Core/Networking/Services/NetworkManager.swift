//
//  NetworkManager.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import Foundation

protocol NetworkManaging {
    func fetch<T: Decodable>(from endpoint: Endpoint, retries: Int) async throws -> T
}

final class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    private let session: URLSession
    private let cache: URLCache = .shared

    private init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(from endpoint: Endpoint, retries: Int = 3) async throws -> T {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 20

        if let cachedResponse = cache.cachedResponse(for: request),
           let decodedData = try? JSONDecoder().decode(T.self, from: cachedResponse.data)
        {
            return decodedData
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        try validateResponse(httpResponse)

        let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            if retries > 0 {
                return try await fetch(from: endpoint, retries: retries - 1)
            } else {
                throw NetworkError.decodingFailed
            }
        }
    }

    private func validateResponse(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200 ... 299:
            return
        case 400 ... 499:
            throw NetworkError.clientError(response.statusCode)
        case 500 ... 599:
            throw NetworkError.serverError(response.statusCode)
        default:
            throw NetworkError.unknownError(response.statusCode)
        }
    }
}
