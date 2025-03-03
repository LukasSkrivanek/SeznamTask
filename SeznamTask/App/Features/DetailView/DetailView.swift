//
//  DetailView.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var appState: AppState
    let book: Book

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                bookImage
                bookTitle
                bookDetails
                bookDescription
                openInGooglePlayButton
                Spacer()
            }
            .padding()
            .redacted(reason: appState.isLoading ? .placeholder : [])
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var bookImage: some View {
        ImageLoader(imageURL: book.thumbnail)
            .frame(maxHeight: 300)
    }

    private var bookTitle: some View {
        Text(book.title)
            .font(.largeTitle)
            .bold()
    }

    @ViewBuilder
    private var bookDetails: some View {
        Text("Autor: \(book.authors.joined(separator: ", "))")
            .font(.title2)
            .foregroundColor(.secondary)
        Text("Rok vydání: \(book.publishedDate)")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }

    @ViewBuilder
    private var bookDescription: some View {
        if let description = book.description {
            Text(description)
                .font(.body)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    @ViewBuilder
    private var openInGooglePlayButton: some View {
        if let url = URL(string: book.infoLink) {
            Text("Otevřít v Google Play")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
                .anyButton {
                    UIApplication.shared.open(url)
                }
        }
    }
}

#Preview {
    DetailView(
        book: Book(
            title: "",
            authors: [],
            thumbnail: "",
            description: "",
            publishedDate: "Date()",
            infoLink: "",
            imageLinks: nil
        )
    )
}
