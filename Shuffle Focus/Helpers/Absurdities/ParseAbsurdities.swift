//
//  ParseAbsurdities.swift
//  Shuffle Focus
//
//  Created by William Smith on 15/06/2024.
//

import Foundation

@Observable
class ParseAbsurdities {
    
    private var _absurdities = [Absurdity]()
    
    var absurdities: [Absurdity] {
        return _absurdities
    }
    
    func onAppStart() -> [Absurdity] {
        if let jsonURL = Bundle.main.url(forResource: "Absurdities", withExtension: "json") {
            if let data = try? Data(contentsOf: jsonURL) {
                let decoder = JSONDecoder()
                
                if let jsonPetitions = try? decoder.decode(Absurdities.self, from: data) {
                    _absurdities = jsonPetitions.results
                    return _absurdities
                }
            }
        }
        return []
    }
}
