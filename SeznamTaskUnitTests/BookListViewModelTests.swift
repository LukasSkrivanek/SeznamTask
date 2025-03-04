//
//  BookListViewModelTests.swift
//  SeznamTask
//
//  Created by macbook on 03.03.2025.
//

@testable import SeznamTask
import XCTest

class BookListViewModelTests: XCTestCase {
    var viewModel: BookListViewModel!
    var mockRepository: MockBooksRepository!
    var appState: AppState!

    override func setUp() async throws {
        mockRepository = MockBooksRepository()

        await MainActor.run {
            appState = AppState()
            viewModel = BookListViewModel(booksRepository: mockRepository, appState: appState)
        }
    }

    func testFetchBooksSuccess() async throws {
        mockRepository.mockBooks = MockData.mockBooks
        await MainActor.run {
            viewModel.textfieldText = "Test Author"
        }
        await viewModel.fetchBooks()

        await MainActor.run {
            XCTAssertFalse(appState.isLoading)
            XCTAssertEqual(viewModel.books.count, 1)
            XCTAssertEqual(viewModel.books.first?.title, "Test Book")
        }
    }

    func testFetchBooksFailure() async throws {
        mockRepository.mockError = URLError(.notConnectedToInternet)
        await MainActor.run {
            viewModel.textfieldText = "Test Author"
        }
        await viewModel.fetchBooks()

        await MainActor.run {
            XCTAssertFalse(appState.isLoading)
            XCTAssertTrue(viewModel.showError)
            XCTAssertEqual(viewModel.errorMessage, URLError(.notConnectedToInternet).localizedDescription)
        }
    }
}
