//
//  BooksRepository 2.swift
//  SeznamTask
//
//  Created by macbook on 05.03.2025.
//

import Foundation

protocol BooksRepository {
    func fetchBooks(for author: String) async throws -> [Book]
}
