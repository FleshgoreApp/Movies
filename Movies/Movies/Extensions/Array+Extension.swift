//
//  Array+Extension.swift
//  Movies
//
//  Created by Anton Shvets on 08.12.2023.
//

import Foundation

extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if set.insert(map(value)).inserted {
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}
