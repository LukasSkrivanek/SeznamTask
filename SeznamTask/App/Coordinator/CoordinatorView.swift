//
//  CoordinatorView.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .searchPage)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
        }
        .environmentObject(coordinator)
    }
}
