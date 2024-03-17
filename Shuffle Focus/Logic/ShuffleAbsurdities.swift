//
//  ShuffleAbsurdities.swift
//  Shuffle Focus
//
//  Created by William Smith on 17/03/2024.
//

import Foundation

struct Absurdity: Codable {
    var name: String
    var image: String
    var detail: String
}

struct Absurdities: Codable {
    var results: [Absurdity]
}

@Observable
class ShuffleAbsurdities {
    
    private var _absurdities = [Absurdity]()
    
    var absurdities: [Absurdity] {
        return _absurdities
    }
    
    func onAppStart() {
        if let jsonURL = Bundle.main.url(forResource: "Absurdities", withExtension: "json") {
            if let data = try? Data(contentsOf: jsonURL) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Absurdities.self, from: json) {
            _absurdities = jsonPetitions.results
        }
    }
}
