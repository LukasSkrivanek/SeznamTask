//
//  SeznamTaskApp.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import SwiftUI

@main
struct SeznamTaskApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environmentObject(DependencyContainer.resolve(Coordinator.self))
                .environmentObject(DependencyContainer.resolve(BookListViewModel.self))
                .environmentObject(DependencyContainer.resolve(AppState.self))
        }
    }
}
