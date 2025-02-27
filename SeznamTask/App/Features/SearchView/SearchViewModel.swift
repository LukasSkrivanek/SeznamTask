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

    init(booksRepository: BooksRepository = BooksRepositoryImpl()) {
        self.booksRepository = booksRepository
    }

    func fetchBooks() async {
        guard !textfieldText.isEmpty else {
            DispatchQueue.main.async {
                self.errorMessage = "Zadejte jméno autora."
                self.showError = true
            }
            return
        }

        DispatchQueue.main.async {
            self.isLoading = true
        }

        do {
            let fetchedBooks = try await booksRepository.fetchBooks(for: textfieldText)
            DispatchQueue.main.async {
                self.books = fetchedBooks
                self.errorMessage = nil
                self.showError = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.showError = true
            }
        }

        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
}
