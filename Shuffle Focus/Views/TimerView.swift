//
//  TimerView.swift
//  Shuffle Timer
//
//  Created by William Smith on 17/03/2024.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var eventManager: EventManager
    
    var shuffleTimer: ShuffleTimer
    var type: TimerType
    
    @State private var appeared = false
    
    var body: some View {
        
        ZStack {
            VStack {
                
                if type == .focus {
                    Text("Focus")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                } else if type == .shortPause || type == .longPause {
                    Text("Break")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }
                
                
                if shuffleTimer.completed {
                    Text("Complete!")
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .onAppear(perform: {
                            if !eventManager.frontComplete {
                                if type == .focus {
                                    print("Focus")
                                    if eventManager.timers < 3 {
                                        eventManager.timers += 1
                                        eventManager.cycles += 1
                                    } else {
                                        eventManager.timers = 0
                                        eventManager.cycles += 1
                                    }
                                    eventManager.pauseFinished = false
                                } else if type == .shortPause || type == .longPause {
                                    print("Break")
                                    if eventManager.pauses < 3 {
                                        eventManager.pauses += 1
                                    } else {
                                        eventManager.pauses = 0
                                    }
                                    eventManager.pauseFinished = true
                                }
                               
                                eventManager.frontComplete = true
                                eventManager.timerStarted = false
                                
                            }
                        })
                } else {
                    if shuffleTimer.secondsLeft >= 0 {
                        Text("\(String(format: "%02d", shuffleTimer.secondsMinutes.m)):\(String(format: "%02d", shuffleTimer.secondsMinutes.s))")
                            .font(.system(size: 50))
                            .foregroundStyle(.white)
                            .tracking(6)
                            .fontWeight(.semibold)
                    }
                }
                
            }
            CircleProgress(timeRemaining: shuffleTimer.secondsLeft, countTo: shuffleTimer.duration)
        }
        
        
        
        if !shuffleTimer.completed {
            switch shuffleTimer.state {
            case .idle:
                Button(action: {
                    withAnimation(.easeInOut) {
                        shuffleTimer.start()
                        if type == .focus {
                            eventManager.timerStarted = true
                        } else {
                            eventManager.pauseFinished = false
                        }
                    }
                }) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }
            case .started:
                Button(action: {
                    withAnimation(.easeInOut) {
                        shuffleTimer.pause()
                    }
                }) {
                    Image(systemName: "pause.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }
            case .paused:
                Button(action: {
                    withAnimation(.easeInOut) {
                        shuffleTimer.resume()
                    }
                }) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }
            }
            
        } else {
            Text("")
                .frame(width: 60, height: 60)
        }
    }
}

#Preview {
    TimerView(shuffleTimer: ShuffleTimer(_timerType: .focus), type: .focus)
}
