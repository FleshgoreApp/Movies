//
//  NetworkServiceProtocol.swift
//  Movies
//
//  Created by Anton Shvets on 08.12.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    var baseURL: String { get }
    init(baseURL: String)
    func sendRequest<D: Decodable>(route: Routable, decodeTo: D.Type) async throws -> D
    func sendRequestWithoutDecodeModel(route: Routable) async throws -> Void
}
