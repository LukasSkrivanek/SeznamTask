//
//  DependencyContainer.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import SwiftUI
import Swinject

class DependencyContainer {
    static let shared = DependencyContainer()
    let container: Container
    private init() {
        container = Container()

        container.register(Coordinator.self) { _ in
            Coordinator()
        }.inObjectScope(.container)
    }

    static func resolve<T>(_ type: T.Type) -> T {
        guard let dependency = shared.container.resolve(type) else {
            fatalError("Dependency for \(type) not found. Check Swinject registrations.")
        }
        return dependency
    }
}
