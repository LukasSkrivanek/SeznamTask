//
//  DependencyContainer.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import SwiftUI
import Swinject

final class DependencyContainer {
    static let shared = DependencyContainer()
    let container: Container
    private init() {
        container = Container()

        container.register(Coordinator.self) { _ in
            Coordinator()
        }.inObjectScope(.container)
        container.register(NetworkManager.self) { _ in
            NetworkManager()
        }
        container.register(BooksRepository.self) { resolve in
            BooksRepositoryImpl(networkManager: resolve.resolve(NetworkManager.self)!)
        }.inObjectScope(.container)
        container.register(BookListViewModel.self) { resolve in
            MainActor.assumeIsolated {
                BookListViewModel(
                    booksRepository: resolve.resolve(BooksRepository.self)!,
                    appState: resolve.resolve(AppState.self)!
                )
            }
        }.inObjectScope(.container)
        container.register(AppState.self) { _ in
            MainActor.assumeIsolated {
                AppState()
            }
        }.inObjectScope(.container)
    }

    static func resolve<T>(_ type: T.Type) -> T {
        guard let dependency = shared.container.resolve(type) else {
            fatalError("Dependency for \(type) not found. Check Swinject registrations.")
        }
        return dependency
    }
}
