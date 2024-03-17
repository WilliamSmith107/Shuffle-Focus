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
        Text("\(image)")
        Image(systemName: "moon.stars.fill")
            .resizable()
            .frame(width: 100, height: 100)
            
        Spacer()
        
        Text("\(detail)")
            .multilineTextAlignment(.center)
            .font(.system(size: 40))
            .foregroundStyle(.white)
            .fontWeight(.semibold)
    }
}

#Preview {
    AbsurdityView(name: "Test", image: "TestImage", detail: "TestDetail")
}
