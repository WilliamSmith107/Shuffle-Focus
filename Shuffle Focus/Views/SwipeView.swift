//
//  SwipeView.swift
//  Shuffle Timer
//
//  Created by William Smith on 16/03/2024.
//

import SwiftUI

class EventManager: ObservableObject {
    @Published var frontComplete: Bool = false
    
    @Published var cycles: Int = 0
    @Published var timers: Int = 0
    @Published var pauses: Int = 0
    
    @Published var timerStarted: Bool = false
    @Published var pauseFinished: Bool = true
    
    @Published var shuffleAbsurdities: ShuffleAbsurdities = ShuffleAbsurdities()
    
    init() {
        shuffleAbsurdities.onAppStart()
    }
}


struct SwipeView: View {
    
    
    @StateObject var eventManager = EventManager()
    
    @State private var offset = CGSize.zero
    
    @State private var currentCard = 0
    @State private var currentColour = 0
    
    @State private var cardViews: [CardView] = [
        CardView(type: .timer, colour: .cardPurple, id: UUID()),
        CardView(type: .blank, colour: .cardBlue, id: UUID()),
        CardView(type: .blank, colour: .cardOrange, id: UUID()),
        CardView(type: .blank, colour: .cardPink, id: UUID())
    ]
    
    let colourOrder : [Color] = [
        .cardPurple,
        .cardBlue,
        .cardOrange,
        .cardPink
    ]
    
    let cardOrder: [CardType] = [
        .absurdity,
        .shortPause,
        .timer
    ]
    
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("Today")
                    .font(.headline)
                    .foregroundColor(Color(UIColor.darkGray))
                Text("\(eventManager.cycles)")
                    .font(.title)
                    .foregroundColor(Color(UIColor.darkGray))
            }
            
            
            Spacer()
            ZStack {
                ForEach(cardViews.indices.reversed(), id: \.self) { index in
                    
                    switch index {
                    case 0:
                        if eventManager.frontComplete {
                            cardViews[index]
                                .offset(y: 10)
                                .rotationEffect(Angle(degrees: 7))
                                .offset(x: index > 0 ? 0 : offset.width, y: index > 0 ? 0 : offset.height * 0.4)
                                .rotationEffect(index > 0 ? .degrees(0) : .degrees(Double(offset.width / 40)))
                                .gesture(index == 0 ? swipeGesture : nil)
                                .environmentObject(eventManager)
                            
                        } else {
                            cardViews[index]
                                .offset(y: 10)
                                .rotationEffect(Angle(degrees: 7))
                                .environmentObject(eventManager)
                            
                        }
                        
                        
                    case 1:
                        cardViews[index]
                            .offset(y: 5)
                            .rotationEffect(Angle(degrees: -3.5))
                        
                    case 2:
                        cardViews[index]
                            .offset(y: -40)
                            .scaleEffect(0.9)
                        
                    case 3:
                        cardViews[index]
                            .offset(y: -90)
                            .scaleEffect(0.8)
                        
                    default:
                        cardViews[index]
                    }
                }
            }
            Spacer()
            HStack {
                ProgressView()
                    .environmentObject(eventManager)
            }
            Spacer()
        }
    }
    
    
    var swipeGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
            }
            .onEnded { _ in
                swipeCard()
            }
    }
    
    
    func swipeCard() {
        guard cardViews.first != nil else { return }
        
        if abs(offset.width) > 75 {
            print("\(cardViews[0].type) removed.")
            
            eventManager.frontComplete = false
            
            
            
            if cardOrder[currentCard] == .timer {
                cardViews[1] = CardView(type: .timer, colour: cardViews[1].colour, id: cardViews[1].id)
            } else if cardOrder[currentCard] == .absurdity {
                cardViews[1] = CardView(type: .absurdity, colour: cardViews[1].colour, id: cardViews[1].id)
            } else if cardOrder[currentCard] == .shortPause && eventManager.pauses < 3 {
                cardViews[1] = CardView(type: .shortPause, colour: cardViews[1].colour, id: cardViews[1].id)
            } else {
                cardViews[1] = CardView(type: .longPause, colour: cardViews[1].colour, id: cardViews[1].id)
            }
            
            
            if currentCard != 2 {
                currentCard += 1
            } else {
                currentCard = 0
            }
            
            
            
            cardViews.removeFirst()
            
            withAnimation(.snappy) {
                cardViews.append(CardView(type: .blank, colour: colourOrder[currentColour], id: UUID()))
            }
            
            if currentColour != 3 {
                currentColour += 1
            } else {
                currentColour = 0
            }
        }
        offset = .zero
    }
}

#Preview {
    SwipeView()
}
