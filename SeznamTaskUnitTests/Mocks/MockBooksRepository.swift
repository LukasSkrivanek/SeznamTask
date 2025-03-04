//
//  MockBooksRepository.swift
//  SeznamTask
//
//  Created by macbook on 03.03.2025.
//
import Foundation
@testable import SeznamTask

class MockBooksRepository: BooksRepository {
    var mockBooks: [Book] = []
    var mockError: Error?

    func fetchBooks(for _: String) async throws -> [Book] {
        if let mockError {
            throw mockError
        }
        return mockBooks
    }
}
