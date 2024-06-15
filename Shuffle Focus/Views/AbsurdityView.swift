//
//  AbsurdityView.swift
//  Shuffle Focus
//
//  Created by William Smith on 17/03/2024.
//

import SwiftUI

struct AbsurdityView: View {
    
    var absurdity: Absurdity
    
    var body: some View {
        Image(absurdity.image)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            
       
        Text("\(absurdity.detail)")
            .multilineTextAlignment(.center)
            .font(.system(size: 32))
            .foregroundStyle(.white)
            .fontWeight(.semibold)
    }
}

#Preview {
    AbsurdityView(absurdity: Absurdity(name: "Onion", image: "Absurdity_Onion", detail: "Pickle an onion!"))
}
