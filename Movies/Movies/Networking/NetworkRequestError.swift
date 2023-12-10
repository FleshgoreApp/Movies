//
//  NetworkRequestError.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import Foundation

enum NetworkRequestError: Error {
    case failedDecoded(decodeMessage: String)
    case badURL
    case responseError(statusCode: Int)
}
