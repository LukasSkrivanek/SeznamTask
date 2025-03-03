//
//  BookListViewModel.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import Foundation

@MainActor
final class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var textfieldText: String = ""
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    private let appState: AppState
    private let booksRepository: BooksRepository

    init(booksRepository: BooksRepository, appState: AppState) {
        self.booksRepository = booksRepository
        self.appState = appState
    }

    func fetchBooks() async {
        guard !textfieldText.isEmpty else {
            errorMessage = "Zadejte jméno autora."
            showError = true
            return
        }

        appState.isLoading = true

        do {
            let fetchedBooks = try await booksRepository.fetchBooks(for: textfieldText)
            books = fetchedBooks
            errorMessage = nil
            showError = false
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
        appState.isLoading = false
    }
}
