//
//  BookListView.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import SwiftUI

struct BookListView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var viewModel: BookListViewModel
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(spacing: 16) {
            searchField
            if viewModel.books.isEmpty {
                emptyState
            } else {
                bookList
            }
        }
        .navigationTitle("Vyhledat knihy")
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Chyba"),
                message: Text(viewModel.errorMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    @ViewBuilder
    private var searchField: some View {
        HStack {
            TextField("Zadejte autora", text: $viewModel.textfieldText, onCommit: {
                Task {
                    await viewModel.fetchBooks()
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.horizontal)

            if appState.isLoading {
                ProgressView()
                    .padding(.trailing, 8)
            } else {
                CircleButton(
                    systemName: "magnifyingglass",
                    foregroundColor: .white,
                    backgroundColor: .blue
                ) {
                    Task {
                        await viewModel.fetchBooks()
                        hideKeyboard()
                    }
                }
                .padding(.trailing, 8)
            }
        }
        .padding(.top, 16)
    }

    @ViewBuilder
    private var emptyState: some View {
        if appState.isLoading {
            Spacer()
            ProgressView("Načítání knih...")
                .font(.headline)
            Spacer()
        } else {
            if #available(iOS 17, *) {
                ContentUnavailableView(
                    "Žádné knihy nenalezeny",
                    systemImage: "magnifyingglass",
                    description: Text("Zkuste změnit vyhledávací kritéria.")
                )
            } else {
                Text("Žádné knihy nenalezeny")
            }
        }
    }

    private var bookList: some View {
        List(viewModel.books, id: \.hashValue) { book in
            BookRow(book: book)
                .anyButton {
                    coordinator.push(page: .detailPage(book))
                }
                .redacted(reason: appState.isLoading ? .placeholder : [])
                .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        }
        .listStyle(InsetListStyle())
    }
}
