//
//  BooksRepository.swift
//  SeznamTask
//
//  Created by macbook on 26.02.2025.
//

import Foundation

final class BooksRepositoryImpl: BooksRepository {
    private var networkManager: NetworkManaging

    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }

    func fetchBooks(for author: String) async throws -> [Book] {
        let endpoint = GoogleBooksEndpoint(author: "inauthor:\(author)")
        let fetchedBooksDTO: GoogleBooksResponseDTO = try await networkManager.fetch(from: endpoint, retries: 3)
        guard let items = fetchedBooksDTO.items else {
            return []
        }

        return items.map { itemDTO in
            let thumbnail = itemDTO.volumeInfo.secureThumbnailURL
            let imageLinks = itemDTO.volumeInfo.imageLinks.map { dto in
                ImageLinks(thumbnail: dto.thumbnail!)
            }
            return Book(
                title: itemDTO.volumeInfo.title,
                authors: itemDTO.volumeInfo.authors ?? ["Neznámy autor"],
                thumbnail: thumbnail ?? "",
                description: itemDTO.volumeInfo.description ?? "Popis není k dispozici",
                publishedDate: itemDTO.volumeInfo.publishedDate ?? "Datum publikace není k dispozici",
                infoLink: itemDTO.volumeInfo.infoLink ?? "",
                imageLinks: imageLinks
            )
        }
    }
}
