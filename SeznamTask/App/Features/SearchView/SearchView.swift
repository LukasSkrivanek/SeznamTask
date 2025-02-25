//
//  SearchView.swift
//  SeznamTask
//
//  Created by macbook on 25.02.2025.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var coordinator: Coordinator
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button {
                coordinator.push(page: .detailPage(0))
            } label: {
                Text("Push")
            }

            Button {
                coordinator.presentSheet(.zero)
            } label: {
                Text("Sheet")
            }
        }
        .padding()
    }
}

#Preview {
    SearchView()
}
