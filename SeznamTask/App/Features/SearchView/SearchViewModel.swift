//
//  SearchViewModel.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import Foundation

@MainActor
final class BooksViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var textfieldText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    private let booksRepository: BooksRepository

    init(booksRepository: BooksRepository) {
        self.booksRepository = booksRepository
    }

    func fetchBooks() async {
        guard !textfieldText.isEmpty else {
            errorMessage = "Zadejte jméno autora."
            showError = true
            return
        }

        isLoading = true

        do {
            let fetchedBooks = try await booksRepository.fetchBooks(for: textfieldText)
            books = fetchedBooks
            errorMessage = nil
            showError = false
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
        isLoading = false
    }
}
