//
//  SimpleCellModel.swift
//  Movies
//
//  Created by Anton Shvets on 08.12.2023.
//

import Foundation

struct SimpleCellModel {
    var url: URL?
    var title: String?
    var footnote: String?
    
    init(movie: MovieEntity) {
        self.url = movie.posterUrl
        self.title = movie.title
        self.footnote = movie.releaseDate
    }
    
    //init(tvShow: TVShowEntity) {}
}
