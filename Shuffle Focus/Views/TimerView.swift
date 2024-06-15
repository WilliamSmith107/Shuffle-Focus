//
//  TimerView.swift
//  Shuffle Timer
//
//  Created by William Smith on 17/03/2024.
//

import SwiftUI

struct TimerView: View {
    
    
    @Binding var card: Card
    
    @State private var viewModel: ViewModel
    
    init(card: Binding<Card>) {
        self._card = card
        viewModel = ViewModel(card: card)
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("\(card.type.description)")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                
                Text(viewModel.complete ? "Complete!" : "\(String(format: "%02d", viewModel.secondsMinutes.m)):\(String(format: "%02d", viewModel.secondsMinutes.s))")
                    .font(.system(size: 50))
                    .foregroundStyle(.white)
                    .tracking(2)
                    .fontWeight(.semibold)
                
                    .onChange(of: viewModel.complete) {
                        card.completed = true
                    }
            }
            
            ProgressRing(timeRemaining: viewModel.secondsRemaining, countTo: viewModel.timerDuration)
        }
        
        VStack {
            VStack {
                if (!viewModel.complete) {
                    Button(action: {
                        switch viewModel.timerState {
                        case .Idle:
                            viewModel.startTimer()
                        case .Started:
                            viewModel.pauseTimer()
                        case .Paused:
                            viewModel.resumeTimer()
                        }
                    }, label: {
                        switch viewModel.timerState {
                        case .Idle, .Paused:
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                        case .Started:
                            Image(systemName: "pause.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                        }
                    })
                }
            }
            .frame(width: 60, height: 60)
            .onChange(of: card) {
                viewModel.endTimer()
            }
        }
    }
}

#Preview {
    TimerView(card: .constant(Card(colour: .blue, type: .Blank)))
}
