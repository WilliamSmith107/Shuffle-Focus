//
//  Notification.swift
//  Shuffle Focus
//
//  Created by William Smith on 15/06/2024.
//

import Foundation

extension NSNotification {
    static let Break = Notification.Name.init("Break")
    static let Focus = Notification.Name.init("Focus")
    static let Reset = Notification.Name.init("Reset")
}
