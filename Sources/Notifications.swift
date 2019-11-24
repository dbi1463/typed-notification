//
//  Notifications.swift
//  TypedNotification
//
//  Created by Spirit on 2019/11/7.
//  Copyright © 2019 Spirit. All rights reserved.
//

import Foundation

public typealias Subscription = Disposable

public struct Notifications {

    #if os(iOS)
    /// All keyboard related notifications.
    public typealias keyboard = KeyboardNotifications

    #endif
}
