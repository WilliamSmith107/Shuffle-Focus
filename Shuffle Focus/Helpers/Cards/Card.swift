//
//  Card.swift
//  Shuffle Focus
//
//  Created by William Smith on 15/06/2024.
//

import Foundation
import SwiftUI


struct Card: Identifiable, Hashable {
    let id = UUID()
    
    var colour: Color
    var type: CardType
    
    var completed = false
    
    var absurdity: Absurdity? = nil
}
