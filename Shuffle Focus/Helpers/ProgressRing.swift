//
//  ProgressRing.swift
//  Shuffle Focus
//
//  Created by William Smith on 15/06/2024.
//

import SwiftUI

struct ProgressRing: View {
    
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

#Preview {
    ProgressRing(timeRemaining: 5, countTo: 10)
}
