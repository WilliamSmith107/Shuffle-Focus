//
//  ShuffleTimer.swift
//  Shuffle Focus
//
//  Created by William Smith on 14/03/2024.
//

import Foundation
import Observation

enum TimerState {
    case idle
    case started
    case paused
}

enum TimerType {
    case focus
    case shortPause
    case longPause
}

struct SecondsMinutes {
    var m: Int
    var s: Int
}

@Observable
class ShuffleTimer {
    
    
    
    // MARK: Timer variables.
    private var timer: Timer?
    private var _duration = 0
    private var timePassed = 0
    
    private var secondsPassedBeforePause: Int = 0
    
    // MARK: Date variables.
    private var dateStarted: Date = Date.now
    
    
    // MARK: State variables.
    private var timerType: TimerType
    private var _state: TimerState = .idle
    private var _completed = false
    
    // MARK: Unit variables.
    private var _s = 0
    private var _m = 0
    
    
    // MARK: Initialiser.
    init(_timerType: TimerType) {
        self.timerType = _timerType
        
        switch timerType {
        case .focus:
            _duration = 2
        case .shortPause:
            _duration = 1
        case .longPause:
            _duration = 3
        }
    }
    
    // MARK: Public variables.
    var secondsLeft: Int {
        Int(duration) - timePassed
    }
    
    var completed: Bool {
        return _completed
    }
    
    var state: TimerState {
        return _state
    }
    
    var duration: Int {
        return _duration
    }
    
    var secondsMinutes: SecondsMinutes {
        (_m, _s) = self.secondsToHoursMinutesSeconds(secondsLeft)
        return SecondsMinutes(m: _m, s: _s)
    }
    
    
    
    // MARK: Timer functions.
    private func createTimer() {
        // Add notification logic.
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timerUpdate()
        }
    }
    
    private func timerUpdate() {
        if self.secondsLeft == 0 {
            print("ShuffleTimer: Complete")
            _completed = true
            endTimer()
        }
        
        
        let secondsSinceStartDate = Date.now.timeIntervalSince(self.dateStarted)
        
        self.timePassed = Int(secondsSinceStartDate) + self._secondsPassedBeforePause
        
        
    }
    
    func start() {
        dateStarted = Date.now
        timePassed = 0
        _state = .started
        createTimer()
    }
    
    func resume() {
        dateStarted = Date.now
        _state = .started
        createTimer()
    }
    
    func pause() {
        secondsPassedBeforePause = timePassed
        _state = .paused
        endTimer()
    }
    
    private func endTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
