//
//  AppState.swift
//  SeznamTask
//
//  Created by macbook on 03.03.2025.
//

import Foundation
import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var isLoading: Bool = false
}
