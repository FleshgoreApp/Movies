//
//  MoviesEntity.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//


struct MoviesEntity: Codable {
    let page: Int?
    let results: [MovieEntity]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
