//
//  ImageLoader.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import SDWebImageSwiftUI
import SwiftUI

struct ImageLoader: View {
    var imageURL: String
    var apiKey: String = APIKeyManager.shared.apiKey!

    var body: some View {
        let fullImageURL = "\(imageURL)\(apiKey)"
        if let url = URL(string: fullImageURL) {
            WebImage(url: url)
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .cornerRadius(8)
                .shadow(radius: 5)
        } else {
            Image(systemName: "book.closed.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .cornerRadius(8)
        }
    }
}
