//
//  MovieCell.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import SwiftUI

struct MovieCell: View {
    private let movie: MovieEntity
    
    init(movie: MovieEntity) {
        self.movie = movie
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottomLeading) {
                image
                gradient
                title
            }
            .frame(width: 200, height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                border
            )
            .overlay {
                circularProgressView
            }
            
            badge
        }
        .frame(width: 200)
    }
    
    @ViewBuilder
    private var circularProgressView: some View {
        if let average = movie.average {
            CircularProgressView(value: average)
                .padding(.top, 8)
                .padding(.trailing, 6)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topTrailing
                )
        }
    }
    
    private var border: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(.gray, lineWidth: 1)
            .opacity(0.4)
    }
    
    @ViewBuilder
    private var image: some View {
        if let url = movie.posterUrl {
            CacheAsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    imagePlaceholder
                }
            }
            .frame(width: 200, height: 300)
        } else {
            imagePlaceholder
        }
    }
    
    @ViewBuilder
    private var badge: some View {
        if let result = movie.countOccurrenceCharacter {
            Badge(text: result)
        }
    }
    
    private var gradient: some View {
        Color(.clear)
            .background(
                LinearGradient(
                    gradient: Gradient(
                        colors: [.clear, .clear, .black]
                    ),
                    startPoint: .center,
                    endPoint: .bottom
                )
            )
    }
    
    @ViewBuilder
    private var title: some View {
        if let title = movie.title {
            Text(title)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
        }
    }
}

#Preview {
    MovieCell(movie:
            .init(
                id: 555,
                title: "Life Is Beautiful",
                average: 8.46,
                posterPath: "/6tEJnof1DKWPnl5lzkjf0FVv7oB.jpg",
                backdropPath: nil,
                overview: nil,
                releaseDate: nil
            )
    )
}
