//
//  MovieEntity.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import Foundation

struct MovieEntity: Codable, Identifiable {
    let id: Int?
    let title: String?
    let average: Double?
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    
    var posterUrl: URL? {
        guard let posterPath else { return nil }
        return URL(string: "\(NetworkConstant.baseImageURL)t/p/w400\(posterPath)")
    }
    
    var backdropUrl: URL? {
        guard let backdropPath else { return nil }
        return URL(string: "\(NetworkConstant.baseImageURL)t/p/w400\(backdropPath)")
    }
    
    var countOccurrenceCharacter: String? {
        guard let title = title else {
            return nil
        }
        return getCountOccurrenceCharacter(from: title)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case average = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    private func getCountOccurrenceCharacter(from string: String) -> String {
        let chars = string.map { $0 }
        var tempDict = [String: String]()
        
        chars.forEach { char in
            let result = string.count(of: char)
            tempDict["\(char)"] = "\(result)"
        }
        
        return tempDict.sorted(by: { $0.key < $1.key }).map {
            $0 == " " ? "space:\($1)" : "\($0):\($1)"
        }.joined(separator: ", ")
    }
}
