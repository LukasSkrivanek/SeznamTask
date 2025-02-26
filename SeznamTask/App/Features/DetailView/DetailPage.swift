//
//  DetailPage.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import SwiftUI

struct DetailPage: View {
    let book: Book

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: book.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                Text(book.title)
                    .font(.largeTitle)
                    .bold()
                Text("Autor: \(book.authors.joined(separator: ", "))")
                    .font(.title2)
                    .foregroundColor(.secondary)

                Text("Rok vydání: \(book.publishedDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if let description = book.description {
                    Text(description)
                        .font(.body)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Button(action: {
                    UIApplication.shared.open(URL(string: book.infoLink)!)
                }) {
                    Text("Otevřít v Google Play")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 16)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Detail knihy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailPage(
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
