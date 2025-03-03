//
//  View + EXT.swift
//  SeznamTask
//
//  Created by macbook on 27.02.2025.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
