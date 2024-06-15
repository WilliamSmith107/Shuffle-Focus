//
//  CardView.swift
//  Shuffle Timer
//
//  Created by William Smith on 16/03/2024.
//

import SwiftUI

struct CardView: View {
    
    // Bound card from SwipeView array.
    @Binding var card: Card
    
    var body: some View {
        
        ZStack {
            // Background for card.
            RoundedRectangle(cornerRadius: 60.0)
                .frame(width: 300, height: 450, alignment: .center)
                .foregroundColor(card.colour)
            
            
            // Show correct view for type of card.
            VStack {
                switch card.type {
                case .Timer:
                    // Show timer.
                    TimerView(card: $card)
                    
                case .ShortPause, .LongPause:
                    // Show timer.
                    TimerView(card: $card)
                    
                case .Absurdity:
                    AbsurdityView(absurdity: card.absurdity!)
                        .padding(30.0)
                    // Mark card as complete to allow swipe.
                        .onAppear(perform: {
                            card.completed = true
                        })
                    
                case .Blank:
                    // Display image to blank card for when visible during gesture.
                    Image(systemName: "square.stack")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 120)
                }
            }
            .frame(width: 300, height: 450)
        }
    }
}

#Preview {
    CardView(card: .constant(Card(colour: .blue, type: .Blank)))
}
