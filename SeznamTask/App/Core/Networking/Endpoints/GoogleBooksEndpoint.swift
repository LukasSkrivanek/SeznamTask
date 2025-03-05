//
//  GoogleBooksEndpoint.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import Foundation

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
            "orderBy": "relevance",
        ]
    }

    let author: String

    init(author: String) {
        self.author = author
    }
}
