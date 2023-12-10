//
//  ImageCache.swift
//  Movies
//
//  Created by Anton Shvets on 08.12.2023.
//

import SwiftUI

final class ImageCache {
    static let shared = ImageCache()
    let limit: Int = 150
    
    init() {
        self.cache.reserveCapacity(50)
    }
    
    private var cache: [URL: Image] = [:]
    private let concurrentQueue = DispatchQueue(
        label: "Dictionary Barrier Queue",
        attributes: .concurrent
    )

    func set(image: Image, url: URL) {
        concurrentQueue.async(flags: .barrier) { [weak self] in
            guard let self else { return }
            if self.cache.keys.count >= self.limit { self.cache = [:] }
            self.cache[url] = image
        }
    }
    
    func get(image url: URL) -> Image? {
        concurrentQueue.sync {
            return cache[url]
        }
    }
}
