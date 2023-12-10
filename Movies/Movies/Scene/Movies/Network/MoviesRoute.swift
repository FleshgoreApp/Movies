//
//  MoviesRoute.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import Foundation

struct MoviesRoute: Routable {
    enum MovieCategoryType {
        case popular(page: Int? = nil)
        case upcoming(page: Int? = nil)
        case topRated(page: Int? = nil)
    }
    
    var type: MovieCategoryType
    
    var path: String {
        switch type {
        case .popular:
            "movie/popular"
        case .upcoming:
            "movie/upcoming"
        case .topRated:
            "movie/top_rated"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch type {
        case let .popular(page), let .topRated(page), let .upcoming(page):
            [
                .init(name: "page", value: "\(page ?? 0)"),
                .init(name: "api_key", value: NetworkConstant.apiKey)
            ]
        }
    }
    
    var httpMethod: NetworkServiceHttpMethod {
        switch type {
        case .popular, .upcoming, .topRated:
            return .GET
        }
    }
    
    var httpBody: Data?
    
    var httpHeaders: [String : String]?
}
