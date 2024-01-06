//
//  RefreshAccessToken.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 14/11/22.
//

import Foundation

/// RefreshTokenTimer singleton class use for refresh the access token in given time interval
class RefreshAccessToken {
    
    private var timer: Timer?
    var onFire: (() -> Void)?
    static let shared = RefreshAccessToken()
    
    /// To check timer is running or not
    var isRunning: Bool {
        timer != nil && timer!.isValid
    }
    
    private init(){}
    
    @objc
    fileprivate func handleTimerEvent() {
        onFire?()
    }
    
    /// Start method use for start the timer with timeinterval to refresh access token
    /// default given time inteveral is 14.84 mins
    func start(withTimeInterval timeInterval: TimeInterval = 890,
               repeats: Bool = true,
               onFire: @escaping () -> Void) {
        guard !isRunning else { return }
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(handleTimerEvent),
                                     userInfo: nil, repeats: repeats)
        self.onFire = onFire
    }
    
    /// Stop method use for stop/invalidate the current timer
    func stop() {
        timer?.invalidate()
        timer = nil
        onFire = nil
    }
}
