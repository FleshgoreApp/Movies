//
//  Badge.swift
//  Movies
//
//  Created by Anton Shvets on 12.12.2023.
//

import SwiftUI

struct Badge: View {
    private let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text("\(text)")
                .font(.headline)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.white)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(
            Color(.greenLight).opacity(0.5)
                .blur(radius: 2)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
    }
}

#Preview {
    Badge(text: "32, 798")
}
