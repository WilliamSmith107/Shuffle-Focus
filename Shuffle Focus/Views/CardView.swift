//
//  CardView.swift
//  Shuffle Timer
//
//  Created by William Smith on 16/03/2024.
//

import SwiftUI

enum CardType {
    case timer
    case shortPause
    case longPause
    case absurdity
    case blank
}



struct CardView: View {
    
    @EnvironmentObject var eventManager: EventManager
    
    var type: CardType
    var colour: Color
    var id: UUID
    
    private var header: String = ""
    
    var shuffleTimer: ShuffleTimer?
    init(type: CardType, colour: Color, id: UUID) {
        self.type = type
        self.colour = colour
        self.id = id
        
        switch type {
        case .timer:
            shuffleTimer = ShuffleTimer(_timerType: .focus)
            header = "Timer"
            
        case .shortPause:
            shuffleTimer = ShuffleTimer(_timerType: .shortPause)
            header = "Short Pause"
            
        case .longPause:
            shuffleTimer = ShuffleTimer(_timerType: .longPause)
            header = "Long Pause"
            
        case .absurdity:
            header = "Absurdity"
            
        case .blank:
            header = "Blank"
            
        }
    }
    
    
    var body: some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 60.0)
                .frame(width: 300, height: 450, alignment: .center)
                .foregroundColor(colour)
            
            
            
            VStack {
                HStack {
                    Text(header)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                
                Spacer()
                
                //Content
                switch type {
                case .timer:
                    TimerView(shuffleTimer: shuffleTimer!, type: .focus)
                        .environmentObject(eventManager)
                    
                case .shortPause:
                    TimerView(shuffleTimer: shuffleTimer!, type: .shortPause)
                        .environmentObject(eventManager)
                    
                case .longPause:
                    TimerView(shuffleTimer: shuffleTimer!, type: .longPause)
                        .environmentObject(eventManager)
                    
                case .absurdity:
                    Text("Absurdity")
                        .onAppear(perform: {
                            eventManager.frontComplete = true
                        })
                    
                case .blank:
                    Text("Blank")
                }
                
                Spacer()
            }
            .padding(30.0)
            .frame(width: 300, height: 450)
        }
    }
}

#Preview {
    CardView(type: .blank, colour: .purple, id: UUID())
}

struct CircleProgress: View {
    
    var timeRemaining : Int
    var countTo : Int
    
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 225, height: 225)
            .overlay(
                Circle()
                    .trim(from: progress(), to: 1)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.orange)
                    .animation(.easeInOut(duration: 0.4), value: progress())
            )
            .rotationEffect(.degrees(-90))
    }
    
    func progress() -> CGFloat {
        return (CGFloat(countTo-timeRemaining) / CGFloat(countTo))
    }
}
