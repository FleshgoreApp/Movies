//
//  MovieDetailView.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import SwiftUI

struct MovieDetailView: View {
    let model: MovieEntity
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                image
                    .frame(
                        maxWidth: proxy.size.width,
                        idealHeight: 200,
                        maxHeight: 300
                    )
                    .padding(.top, 12)
                
                description
                    .padding(.horizontal, 15)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("\(model.title ?? "Movie Details")")
        }
    }
    
    @ViewBuilder
    private var description: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let title = model.releaseDate {
                Text(title)
                    .font(.title3.weight(.semibold))
                    .padding(.top, 15)
                Divider()
            } else {
                Spacer()
            }
            
            if let overview = model.overview {
                Text(overview)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    @ViewBuilder
    private var image: some View {
        if let url = model.backdropUrl {
            CacheAsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    imagePlaceholder
                }
            }
        } else {
            imagePlaceholder
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(model:
                .init(
                    id: 97934586,
                    title: "The Shawshank Redemption",
                    average: 7.17,
                    posterPath: "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
                    backdropPath: "/kGzFbGhp99zva6oZODW5atUtnqi.jpg", 
                    overview: "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
                    releaseDate: "1974-12-20"
                )
        )
    }
}
