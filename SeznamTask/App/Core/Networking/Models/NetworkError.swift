//
//  NetworkError.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingFailed
    case clientError(Int)
    case serverError(Int)
    case unknownError(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            "Invalid response received from the server."
        case .decodingFailed:
            "Failed to decode the response data."
        case let .clientError(statusCode):
            "Client error occurred. Status code: \(statusCode)"
        case let .serverError(statusCode):
            "Server error occurred. Status code: \(statusCode)"
        case let .unknownError(statusCode):
            "An unknown error occurred. Status code: \(statusCode)"
        }
    }
}
