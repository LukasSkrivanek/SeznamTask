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
                ImageLoader(imageURL: book.thumbnail)
                    .frame(maxHeight: 300)
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
                Text("Otevřít v Google Play")
                    .anyButton(.plain, action: {
                        UIApplication.shared.open(URL(string: book.infoLink)!)
                    })
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                Spacer()
            }
            .padding()
        }
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
