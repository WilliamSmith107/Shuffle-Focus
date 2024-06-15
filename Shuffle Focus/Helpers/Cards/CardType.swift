//
//  CardType.swift
//  Shuffle Focus
//
//  Created by William Smith on 15/06/2024.
//

import Foundation

enum CardType: CustomStringConvertible {
    case Timer
    case ShortPause
    case LongPause
    case Absurdity
    case Blank
    
    // Return for card label.
    var description: String {
        switch self {
        case .Timer: return "Focus"
        case .ShortPause, .LongPause: return "Break"
        case .Absurdity: return "Absurdity"
        case .Blank: return "Blank"
        }
    }
}
