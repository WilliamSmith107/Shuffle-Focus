//
//  TimerView-ViewModel.swift
//  Shuffle Focus
//
//  Created by William Smith on 15/06/2024.
//


import Foundation
import SwiftUI
import UserNotifications

extension TimerView {
    @Observable
    class ViewModel {
        
        var card: Binding<Card>
        
        
        // MARK: Initialiser.
        init(card: Binding<Card>) {
            self._card = card
            
            
            // Assign timer duration.
            switch card.type.wrappedValue {
            case .Timer:
                timerDuration = 1500
            case .ShortPause:
                timerDuration = 300
            case .LongPause:
                timerDuration = 1800
            case .Blank, .Absurdity:
                timerDuration = 0
            }
        }
        
        
        // Total timer duration.
        private(set) var timerDuration: Int = 0
        private(set) var timePassed = 0
        
        private(set) var complete = false
        
        
        // Current state of timer, hasn't started.
        private(set) var timerState: TimerState = .Idle
        
        
        private var dateStarted: Date = Date.now
        private var secondsPassedBeforePause: Int = 0
        
        
        // Actual timer for countdown.
        private var countdownTimer: Timer?
        
        
        var secondsRemaining: Int {
            Int(timerDuration) - timePassed
        }
        
        
        var secondsMinutes: SecondsMinutes {
            var s, m: Int
            (m, s) = self.secondsToMinutesSeconds(secondsRemaining)
            return SecondsMinutes(m: m, s: s)
        }
        
        
        // MARK: Timer functions.
        func createTimer() {
            
            scheduleNotification(seconds: TimeInterval(secondsRemaining), title: "Timer Done", body: "Your timer is complete.")
            
            // Creates a timer that fires every second, calling the update.
            countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.updateTimer()
            }
        }
        
        
        func updateTimer() {
            // Check that time remains.
            if (secondsRemaining <= 0) {
                print("Timer complete.")
                print(card.type.wrappedValue )
                complete = true
                
                // Update the total number of breaks.
                if (card.type.wrappedValue == .Timer) {
                    NotificationCenter.default.post(name: NSNotification.Break,
                                                    object: nil)
                }
                
                if (card.type.wrappedValue == .LongPause) {
                    NotificationCenter.default.post(name: NSNotification.Reset,
                                                    object: nil)
                }
                
                endTimer()
                
                return
            }
            
            let secondsSinceStartDate = Date.now.timeIntervalSince(self.dateStarted)
            
            timePassed = Int(secondsSinceStartDate) + secondsPassedBeforePause
        }
        
        
        // First time timer started.
        func startTimer() {
            dateStarted = Date.now
            timePassed = 0
            timerState = .Started
            
            createTimer()
            
            if (card.type.wrappedValue == .Timer) {
                NotificationCenter.default.post(name: NSNotification.Focus,
                                                object: nil)
            }
        }
        
        
        func resumeTimer() {
            dateStarted = Date.now
            timerState = .Started
            
            createTimer()
        }
        
        
        func pauseTimer() {
            secondsPassedBeforePause = timePassed
            timerState = .Paused
            
            endTimer()
        }
        
        
        func endTimer() {
            // Invalidate timer.
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
        
        
        func secondsToMinutesSeconds(_ seconds: Int) -> (Int, Int) {
            return ((seconds % 3600) / 60, (seconds % 3600) % 60)
        }
        
        
        enum TimerState {
            case Idle
            case Started
            case Paused
        }
        
        
        
        
        func scheduleNotification(seconds: TimeInterval, title: String, body: String) {
            let notificationCenter = UNUserNotificationCenter.current()
            
            notificationCenter.removeAllDeliveredNotifications()
            notificationCenter.removeAllPendingNotificationRequests()
            
            let content = UNMutableNotificationContent()
            
            content.title = title
            content.body = body
            content.sound = .default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
            
            let request = UNNotificationRequest(identifier: "shuffle-notification", content: content, trigger: trigger)
            notificationCenter.add(request)
        }
    }
}

struct SecondsMinutes {
    var m: Int
    var s: Int
}

