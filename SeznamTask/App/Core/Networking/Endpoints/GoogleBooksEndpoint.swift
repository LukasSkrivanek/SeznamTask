//
//  GoogleBooksEndpoint.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import Foundation

final class APIKeyManager {
    static let shared = APIKeyManager()

    private(set) var apiKey: String?

    private init() {
        loadAPIKey()
    }

    private func loadAPIKey() {
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String {
            self.apiKey = apiKey
        } else {
            print("API Key not found")
        }
    }
}

struct GoogleBooksEndpoint: Endpoint {
    var baseURL: URL {
        URL(string: "https://www.googleapis.com/books/v1")!
    }

    var path: String {
        "/volumes"
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String]? {
        nil
    }

    var parameters: [String: Any]? {
        [
            "q": author,
            "langRestrict": "cs",
            "key": APIKeyManager.shared.apiKey!,
            "maxResults": 40,
        ]
    }

    let author: String

    init(author: String) {
        self.author = author
    }
}
