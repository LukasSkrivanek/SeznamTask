//
//  SearchView.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var viewModel: BooksViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
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

                    if viewModel.isLoading {
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
                            }
                        }
                        .padding(.trailing, 8)
                    }
                }
                .padding(.top, 16)
                if viewModel.books.isEmpty {
                    if viewModel.isLoading {
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
                } else {
                    List(viewModel.books, id: \.hashValue) { book in
                        BookRow(book: book)
                            .anyButton {
                                coordinator.push(page: .detailPage(book))
                            }
                            .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    }
                    .listStyle(InsetListStyle())
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
    }
}
