//
//  ProgressView.swift
//  Shuffle Focus
//
//  Created by William Smith on 17/03/2024.
//

import SwiftUI

struct ProgressView: View {
    
    @EnvironmentObject var eventManager: EventManager
    
    @State var progressCircles: [ProgressCircle] = [
        ProgressCircle(state: .idle),
        ProgressCircle(state: .idle),
        ProgressCircle(state: .idle),
        ProgressCircle(state: .idle)
    ]
    
    
    var body: some View {
        HStack {
            ForEach(0 ..< 4) {index in
                if eventManager.timerStarted && index == eventManager.timers {
                    progressCircles[index]
                        .onAppear(perform: {
                            progressCircles[index].state = .inProgress
                        })
                } else if !eventManager.timerStarted && (index == eventManager.timers-1 || index == 3 && eventManager.timers == 0 && progressCircles[index].state == .inProgress) && eventManager.frontComplete {
                    progressCircles[index]
                        .onAppear(perform: {
                            progressCircles[index].state = .complete
                        })
                } else if eventManager.pauseFinished && eventManager.timers == 0 {
                    progressCircles[index]
                        .onAppear(perform: {
                            progressCircles[index].state = .idle
                        })
                } else {
                    progressCircles[index]
                }
            }
        }
    }
}

#Preview {
    ProgressView()
}



enum ProgressState {
    case idle
    case inProgress
    case complete
}

struct ProgressCircle: View {
    
    var state: ProgressState
    
    var body: some View {
        if state == .idle {
            Circle()
                .stroke(Color(UIColor.darkGray), lineWidth: 5)
                .frame(width: 35, height: 35)
        } else if state == .inProgress{
            Circle()
                .stroke(Color(UIColor.darkGray), lineWidth: 5)
                .background(Circle()
                    .trim(from: 0, to: 0.5)
                    .rotationEffect(Angle(degrees: 90))
                    .foregroundColor(Color(UIColor.darkGray))
                    )
                .frame(width: 35, height: 35)
                
        } else if state == .complete {
            Circle()
                .stroke(Color(UIColor.darkGray), lineWidth: 5)
                .background(Circle().fill(Color(UIColor.darkGray)))
                .frame(width: 35, height: 35)
        }
    }
}





