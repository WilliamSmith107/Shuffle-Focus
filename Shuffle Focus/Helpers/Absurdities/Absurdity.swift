//
//  Absurdity.swift
//  Shuffle Focus
//
//  Created by William Smith on 15/06/2024.
//

import Foundation

struct Absurdity: Codable, Hashable {
    var name: String
    var image: String
    var detail: String
}

struct Absurdities: Codable {
    var results: [Absurdity]
}
