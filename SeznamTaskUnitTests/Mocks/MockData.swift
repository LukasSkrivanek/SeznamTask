//
//  MockData.swift
//  SeznamTaskTests
//
//  Created by macbook on 04.03.2025.
//

@testable import SeznamTask

class MockData {
    static let mockBooks = [
        Book(
            title: "Test Book",
            authors: ["Test Author"],
            thumbnail: "https://example.com",
            description: "Test Description",
            publishedDate: "2023",
            infoLink: "https://example.com",
            imageLinks: ImageLinks(thumbnail: "https://example.com")
        ),
    ]

    static let mockResponseData = """
    {
        "items": [
            {
                "id": "1",
                "volumeInfo": {
                    "title": "Test Book",
                    "authors": ["Test Author"],
                    "description": "Test Description",
                    "publishedDate": "2023",
                    "imageLinks": { "thumbnail": "https://example.com" },
                    "infoLink": "https://example.com"
                }
            }
        ]
    }
    """.data(using: .utf8)!
}
