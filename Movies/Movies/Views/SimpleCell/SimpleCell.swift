//
//  SimpleCell.swift
//  Movies
//
//  Created by Anton Shvets on 08.12.2023.
//

import SwiftUI

struct SimpleCell: View {
    let model: SimpleCellModel
    
    var body: some View {
        HStack(spacing: 12) {
            image
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                if let title = model.title {
                    Text(title)
                        .font(.callout.weight(.medium))
                        .lineLimit(1)
                }
                if let releaseDate = model.footnote {
                    Text(releaseDate)
                        .font(.footnote)
                        .lineLimit(1)
                }
            }
        }
    }
    
    @ViewBuilder
    private var image: some View {
        if let url = model.url {
            CacheAsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    imagePlaceholderCompact
                }
            }
        } else { 
            imagePlaceholderCompact
        }
    }
}

#Preview {
    let movie = MovieEntity(
        id: 555,
        title: "Fight Club",
        average: 8.46,
        posterPath: "/ApdijpVm1GNV9BQMOsGcAXq4gEB.jpg",
        backdropPath: nil,
        overview: nil,
        releaseDate: "20/20/2034"
    )
    
    return SimpleCell(model: .init(movie: movie))
}
