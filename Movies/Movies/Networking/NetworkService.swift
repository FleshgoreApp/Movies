//
//  NetworkService.swift
//  Movies
//
//  Created by Anton Shvets on 07.12.2023.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    private(set) var baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func sendRequest<D: Decodable>(
        route: Routable,
        decodeTo: D.Type
    ) async throws -> D {
        let request = try await makeURLRequest(route: route)
        let (data, response) = try await URLSession.shared.data(for: request)
        try await isSuccessResponse(response: response)
        return try await decodeData(data: data, to: D.self)
    }

    func sendRequestWithoutDecodeModel(
        route: Routable
    ) async throws -> Void {
        let request = try await makeURLRequest(route: route)
        let (_, response) = try await URLSession.shared.data(for: request)
        return try await isSuccessResponse(response: response)
    }
}

private extension NetworkService {
    func decodeData<D: Decodable>(data: Data, to: D.Type) async throws -> D {
        do {
            return try JSONDecoder().decode(D.self, from: data)
        } catch {
            throw NetworkRequestError.failedDecoded(decodeMessage: "\(error)")
        }
    }

    func makeURLRequest(route: Routable) async throws -> URLRequest {
        guard
            var baseURL = URL(string: baseURL)
        else {
            throw NetworkRequestError.badURL
        }

        baseURL.appendPathComponent(route.path)

        guard
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        else {
            throw NetworkRequestError.badURL
        }

        components.queryItems = route.queryItems

        guard
            let endpointURL = components.url
        else {
            throw NetworkRequestError.badURL
        }

        //Cache 5 minutes
        var request = URLRequest(
            url: endpointURL,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: 60 * 5
        )
        request.httpMethod = route.httpMethod.rawValue
        request.httpBody = route.httpBody
        request.allHTTPHeaderFields = makeDefaultHeaders(additionalHeaders: route.httpHeaders)

        return request
    }

    func isSuccessResponse(response: URLResponse) async throws -> Void {
        guard
            let httpResponse = response as? HTTPURLResponse,
            200...299 ~= httpResponse.statusCode
        else {
            throw NetworkRequestError.responseError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }

        return
    }

    func makeDefaultHeaders(additionalHeaders: [String: String]?) -> [String: String] {
        var baseHeaders = [String: String]()

        ["accept": "application/json"].forEach { key, value in
            baseHeaders.updateValue(value, forKey: key)
        }

        if let additionalHeaders {
            additionalHeaders.forEach { key, value in
                baseHeaders.updateValue(value, forKey: key)
            }
        }

        return baseHeaders
    }
}
