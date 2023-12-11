//
//  CategoryRow.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [MovieEntity]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(categoryName)
                .font(.title2.weight(.bold))
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: .zero) {
                    ForEach(items, id: \.id) { movie in
                        NavigationLink {
                            MovieDetailView(model: movie)
                        } label: {
                            MovieCell(movie: movie)
                                .padding(.leading, 15)
                        }
                    }
                }
                .padding(.trailing, 15)
            }
        }
    }
}


#Preview {
    let sampleMovies: [MovieEntity] = [
        .init(
            id: 9032634,
            title: "The Godfather",
            average: 8.46,
            posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
            backdropPath: "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg",
            overview: "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
            releaseDate: "1974-12-20"
        ),
        .init(
            id: 76847236,
            title: "The Shawshank Redemption",
            average: 5.7,
            posterPath: "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
            backdropPath: "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg",
            overview: "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
            releaseDate: "1974-12-20"
        ),
        .init(
            id: 598792,
            title: "Inferno",
            average: 10,
            posterPath: "/oyG9TL7FcRP4EZ9Vid6uKzwdndz.jpg",
            backdropPath: "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg",
            overview: "Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
            releaseDate: "1974-12-20"
        )
    ]
    
    return NavigationStack {
        CategoryRow(
            categoryName: "Top rated",
            items: sampleMovies
        )
    }
}
