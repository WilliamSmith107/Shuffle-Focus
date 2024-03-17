//
//  CardView.swift
//  Shuffle Timer
//
//  Created by William Smith on 16/03/2024.
//

import SwiftUI
import SwiftData

enum CardType {
    case timer
    case shortPause
    case longPause
    case absurdity
    case blank
}



struct CardView: View {

    
    
    
    // Environment object.
    @EnvironmentObject var eventManager: EventManager
    
    var type: CardType
    var colour: Color
    var id: UUID
    
    private var header: String = ""

    private var randomInt: Int = 0
    
    var shuffleTimer: ShuffleTimer?
    init(type: CardType, colour: Color, id: UUID) {
        self.type = type
        self.colour = colour
        self.id = id
        
        
        randomInt = Int.random(in: 0..<4)
        
        switch type {
        case .timer:
            shuffleTimer = ShuffleTimer(_timerType: .focus)
            header = "Timer"
            
        case .shortPause:
            shuffleTimer = ShuffleTimer(_timerType: .shortPause)
            header = "Break"
            
        case .longPause:
            shuffleTimer = ShuffleTimer(_timerType: .longPause)
            header = "Long Break"
            
        case .absurdity:
            header = ""
            
        case .blank:
            header = ""
            
        }
    }
    
    
    var body: some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 60.0)
                .frame(width: 300, height: 450, alignment: .center)
                .foregroundColor(colour)
            
            
            
            VStack {
                HStack {
                    Text("")
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
                    AbsurdityView(name: eventManager.shuffleAbsurdities.absurdities[randomInt].name, image: eventManager.shuffleAbsurdities.absurdities[randomInt].image, detail: eventManager.shuffleAbsurdities.absurdities[randomInt].detail)
                        .onAppear(perform: {
                            eventManager.frontComplete = true
                        })
                    
                case .blank:
                    Image(systemName: "square.stack")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 120)
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
