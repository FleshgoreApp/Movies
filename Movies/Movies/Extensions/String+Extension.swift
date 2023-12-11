//
//  String+Extension.swift
//  Movies
//
//  Created by Anton Shvets on 11.12.2023.
//

import Foundation

extension String {
    func count(of char: Character) -> Int {
        reduce(0) {
            $1 == char ? $0 + 1 : $0
        }
    }
}
