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
    var apiKey: String = "AIzaSyDy4zbINh8lSmv6EFq7BYd3NMW10tMoh6A"

    var body: some View {
        let fullImageURL = "\(imageURL)\(apiKey)"
        if let url = URL(string: fullImageURL) {
            WebImage(url: url)
                .onSuccess { _, _, _ in
                    print("Obrázek úspěšně načten")
                }
                .onFailure { _ in
                    print("Nepodařilo se načíst obrázek z URL: \(url)")
                }
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 300)
        } else {
            Text("Nepodařilo se načíst obrázek")
                .foregroundColor(.gray)
                .frame(width: 200, height: 300)
        }
    }
}
