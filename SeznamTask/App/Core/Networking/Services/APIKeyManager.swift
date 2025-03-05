//
//  APIKeyManager.swift
//  SeznamTask
//
//  Created by macbook on 05.03.2025.
//

import Foundation

final class APIKeyManager {
    static let shared = APIKeyManager()

    private(set) var apiKey: String?
    private let bundle: Bundle

    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
        loadAPIKey()
    }

    private func loadAPIKey() {
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String {
            self.apiKey = apiKey
        } else {
            fatalError("API Key not found in Info.plist. Please add 'API_KEY' to Info.plist.")
        }
    }
}
