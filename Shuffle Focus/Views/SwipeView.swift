//
//  SwipeView.swift
//  Shuffle Timer
//
//  Created by William Smith on 16/03/2024.
//

import SwiftUI

struct SwipeView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        
        VStack {
            Text("Today")
                .foregroundStyle(.gray)
            Text("\(viewModel.cycles)")
                .font(.title)
        }
        
        Spacer()
        
        ZStack {
            
            // For each card in the array, apply to a card view with the necessary positioning.
            ForEach(viewModel.cards.indices.reversed(), id: \.self) { card in
                
                CardView(card: $viewModel.cards[card])
                    .offset(y: CGFloat(viewModel.cardOffsets[card]))
                    .rotationEffect(Angle(degrees: viewModel.cardRotations[card]))
                    .scaleEffect(viewModel.cardScales[card])
                
                //Applied only if front card.
                    .offset(x: card == 0 ? viewModel.offset.width : 0, y: card == 0 ? viewModel.offset.height * 0.4 : 0)
                    .rotationEffect(card == 0 && viewModel.cards[card].completed ? .degrees(Double(viewModel.offset.width / 40)) : .degrees(0))
                    .gesture(card == 0 && viewModel.cards[card].completed ? viewModel.swipeGesture : nil)
            }
        }
        
        Spacer()
        
        
        
        HStack {
            ForEach(0..<4) { num in
                if (num < viewModel.pauses) {
                    FocusCircle(state: .complete)
                } else if (viewModel.started && num <= viewModel.pauses) {
                    FocusCircle(state: .inProgress)
                } else {
                    FocusCircle(state: .idle)
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Break)) { _ in
            viewModel.updatePauses()
            viewModel.started = false
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Focus)) { _ in
            viewModel.started = true
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Reset)) { _ in
            viewModel.updatePauses()
            viewModel.cycles += 1
        }
    }
}

#Preview {
    SwipeView()
}
