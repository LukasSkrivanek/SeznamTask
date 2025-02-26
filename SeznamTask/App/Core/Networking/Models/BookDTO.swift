//
//  BookDTO.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import Foundation

struct GoogleBooksResponseDTO: Decodable {
    let items: [BookItemDTO]?
}

struct BookItemDTO: Decodable {
    let id: String
    let volumeInfo: VolumeInfoDTO
}

struct VolumeInfoDTO: Decodable {
    let title: String
    let authors: [String]?
    let description: String?
    let publishedDate: String?
    let imageLinks: ImageLinksDTO?
    let infoLink: String?
    var secureThumbnailURL: String? {
        guard let thumbnail = imageLinks?.thumbnail else { return nil }
        return thumbnail.replacingOccurrences(of: "http://", with: "https://")
    }
}

struct ImageLinksDTO: Decodable {
    let thumbnail: String?
}
