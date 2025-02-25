//
//  AppPages.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import Foundation

enum AppPages: Hashable {
    case searchPage
    case detailPage(Int)
}

enum Sheet: String, Identifiable {
    var id: String {
        rawValue
    }

    case zero
}

enum FullScreenCover: String, Identifiable {
    var id: String {
        rawValue
    }

    case zero
}
