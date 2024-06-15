//
//  FocusCircle.swift
//  Shuffle Focus
//
//  Created by William Smith on 15/06/2024.
//

import SwiftUI

struct FocusCircle: View {
    
    var state: FocusState
    
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

#Preview {
    FocusCircle(state: .complete)
}

enum FocusState {
    case idle
    case inProgress
    case complete
}
