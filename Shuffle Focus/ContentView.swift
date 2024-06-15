//
//  ContentView.swift
//  Shuffle Focus
//
//  Created by William Smith on 13/03/2024.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    var body: some View {
        VStack {
            
            // Display SwipeView for app logic.
            SwipeView()
            Spacer()

        }
        .padding()
        .onAppear(perform: {
            UIApplication.shared.isIdleTimerDisabled = true
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                } else if let error {
                    print(error.localizedDescription)
                }
            }
        })
    }
}

#Preview {
    ContentView()
}
