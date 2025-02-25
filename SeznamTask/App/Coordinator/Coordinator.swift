//
//  Coordinator.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import Foundation
import SwiftUI

class Coordinator: Coordinating, ObservableObject {
    @Published var path: NavigationPath = .init()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?

    func push(page: AppPages) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        if !path.isEmpty {
            path.removeLast(path.count)
        }
    }

    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }

    func presentFullScreenCover(_ fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }

    func dismissSheet() {
        sheet = nil
    }

    func dismissCover() {
        fullScreenCover = nil
    }

    @MainActor
    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .searchPage: SearchView()
        case .detailPage: DetailPage()
        }
    }

    @MainActor
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .zero: DetailPage()
        }
    }
}

protocol Coordinating: ObservableObject {
    var path: NavigationPath { get set }
    var sheet: Sheet? { get set }
    var fullScreenCover: FullScreenCover? { get set }

    func push(page: AppPages)
    func pop()
    func popToRoot()

    func presentSheet(_ sheet: Sheet)
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover)

    func dismissSheet()
    func dismissCover()
}
