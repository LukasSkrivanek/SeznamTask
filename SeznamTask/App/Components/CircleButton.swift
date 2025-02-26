//
//  CircleButton.swift
//  SeznamTask
//
//  Created by macbook on 26.02.2025.
//

import SwiftUI

struct CircleButton: View {
    let systemName: String
    let foregroundColor: Color
    let backgroundColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(foregroundColor)
                .padding(10)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }
}
