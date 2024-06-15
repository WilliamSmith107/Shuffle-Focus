//
//  SwipeView-ViewModel.swift
//  Shuffle Focus
//
//  Created by William Smith on 11/06/2024.
//

import Foundation
import SwiftUI

extension SwipeView {
    @Observable
    class ViewModel {
        
        
        var absurdities: [Absurdity]
        
        init() {
            absurdities = ParseAbsurdities().onAppStart()
        }
        private var randomInt: Int = 0
        
        var cycles: Int = 0
        var pauses: Int = 0
        var started: Bool = false
        
        
        // Array of card struct to apply to CardViews.
        var cards: [Card] = [
            Card(colour: .cardPurple, type: .Timer),
            Card(colour: .cardBlue, type: .Blank),
            Card(colour: .cardOrange, type: .Blank),
            Card(colour: .cardPink, type: .Blank)
        ]
        
        
        // MARK: Static arrays for card ordering.
        // Order of card type.
        let cardOrder: [CardType] = [
            .Absurdity,
            .ShortPause,
            .Timer
        ]
        
        // Order of card colours.
        let colourOrder: [Color] = [
            .cardPurple,
            .cardBlue,
            .cardOrange,
            .cardPink
        ]
        
        // Card positions.
        let cardOffsets: [Int] = [10, 5, -40, -90]
        let cardRotations: [Double] = [7, -3, 0, 0]
        let cardScales: [Double] = [1, 1, 0.9, 0.8]
        
        
        // MARK: Swipe handling variables.
        // Track back card colour and type.
        private(set) var currentCard = 0
        private(set) var currentColour = 0
        
        // Front card offset for swipe gesture.
        var offset = CGSize.zero
        
        // Swipe gesture,
        var swipeGesture: some Gesture {
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { _ in
                    self.swipeCard()
                }
        }
        
        
        // Function to remove front card and add back, updating card type so 3 back cards are blank.
        func swipeCard() {
            
            // Check the card has been swiped far enough.
            if (abs(offset.width) > 75) {
                
                // Store a copy of current cards.
                var newCards = cards
                
                // Apply the colour to the new front card.
                if (pauses < 4 || cardOrder[currentCard] != .ShortPause) {
                    newCards[1].type = cardOrder[currentCard]
                    if (cardOrder[currentCard] == .Absurdity) {
                        randomInt = Int.random(in: 0..<absurdities.count)
                        newCards[1].absurdity = absurdities[randomInt]
                    }
                } else if (cardOrder[currentCard] == .ShortPause) {
                    newCards[1].type = .LongPause
                }
                newCards[1].colour = newCards[1].colour
                
                
                // Increment current front card.
                if (currentCard != 2) {
                    currentCard += 1
                } else {
                    currentCard = 0
                }
                
                // Remove old front card.
                newCards.removeFirst()
                
                // Add new card to back in correct colour.
                newCards.append(Card(colour: colourOrder[currentColour], type: .Blank))
                
                // Increment current colour.
                if currentColour != 3 {
                    currentColour += 1
                } else {
                    currentColour = 0
                }
                
                
                withAnimation(.snappy) {
                    self.cards[3] = newCards[3]
                }
                
                // Apply changes to bound array.
                self.cards = newCards
                
            }
            
            // Reset front card's offset, even if card wasn't removed in case gesture ended.
            self.offset = .zero
        }
        
        
        
        
        
        func updatePauses() {
            
            if (pauses < 4) {
                pauses += 1
            } else {
                pauses = 0
            }
        }
    }
}
