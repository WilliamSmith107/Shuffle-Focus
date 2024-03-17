//
//  AbsurdityView.swift
//  Shuffle Focus
//
//  Created by William Smith on 17/03/2024.
//

import SwiftUI

struct AbsurdityView: View {
    
    var name: String
    var image: String
    var detail: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            
        Spacer()
        
        Text("\(detail)")
            .multilineTextAlignment(.center)
            .font(.system(size: 32))
            .foregroundStyle(.white)
            .fontWeight(.semibold)
    }
}

#Preview {
    AbsurdityView(name: "Test", image: "TestImage", detail: "TestDetail")
}
