//
//  CircularProgressView.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import SwiftUI

struct CircularProgressView: View {
    let value: CGFloat
    private let lineWidth = 5.0
    private let size = 42.0
    
    private var title: String {
        "\(Int((value * 10).rounded()))"
    }
    
    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: .zero) {
                Group {
                    Text(title)
                        .font(.caption.weight(.bold))
                    Text("%")
                        .font(.system(size: 8))
                        .fontWeight(.medium)
                }
                .foregroundStyle(.white)
            }
            
            Circle()
                .stroke(
                    Color(.greenLight).opacity(0.5),
                    lineWidth: lineWidth
                )
            
            Circle()
                .trim(from: 0, to: value/10)
                .stroke(
                    Color(.greenLight),
                    style: .init(
                        lineWidth: lineWidth,
                        lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
        }
        .frame(width: size, height: size)
        .padding(2)
        .background(.greenDark)
        .clipShape(Capsule())
    }
}

#Preview {
    CircularProgressView(value: 6.5889)
}
