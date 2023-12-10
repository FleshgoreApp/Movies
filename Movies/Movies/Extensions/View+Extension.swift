//
//  View+Extension.swift
//  Movies
//
//  Created by Anton Shvets on 08.12.2023.
//

import SwiftUI

extension View {
    private var imagePlaceholderBase: some View {
        HStack {
            Image(systemName: "photo")
                .foregroundStyle(.gray)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
    
    var imagePlaceholder: some View {
        imagePlaceholderBase
            .scaleEffect(4)
    }
    
    var imagePlaceholderCompact: some View {
        imagePlaceholderBase
            .scaleEffect(1.5)
    }
}
