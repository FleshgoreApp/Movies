//
//  RoutableProtocol.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import Foundation

protocol Routable {
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var httpMethod: NetworkServiceHttpMethod { get }
    var httpBody: Data? { get }
    var httpHeaders: [String: String]? { get }
}
