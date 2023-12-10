//
//  MoviesModel.swift
//  Movies
//
//  Created by Anton Shvets on 08.12.2023.
//

import Foundation

struct MoviesModel {
    var list: [MovieEntity] = []
    let id: UUID = UUID()
    var currentPage = 1
    var totalPages: Int?
    var totalResults: Int?
    
    mutating func update(with entity: MoviesEntity) {
        guard let page = entity.page,
              let movies = entity.results
        else {
            return
        }
        currentPage = page
        totalPages = entity.totalPages
        totalResults = entity.totalResults
        list.append(contentsOf: movies)
    }
}
