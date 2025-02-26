//
//  Book.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import Foundation

struct Book: Hashable {
    let id = UUID().uuidString
    let title: String
    let authors: [String]
    let thumbnail: String
    let description: String?
    let publishedDate: String
    let infoLink: String
    let imageLinks: ImageLinks?
}

struct ImageLinks: Hashable {
    let thumbnail: String
}
