//
//  Notifications.swift
//  TypedNotification
//
//  Created by Spirit on 2019/11/7.
//  Copyright © 2019 Spirit. All rights reserved.
//

import Foundation

public typealias Subscription = Disposable

public typealias SimpleNotificationHandler = () -> ()

public typealias TypedNotificationHandler<InfoType> = (InfoType) -> ()

public typealias InfoConverter<InfoType> = (Notification) -> InfoType?

/// The developer can confirm this protocol to be a subscribeable
/// event with common + operator to register a handler that does
/// not require any converted information.
public struct NamedNotification {

    /// The represented notification name.
    let name: Notification.Name
}


/// The developer can confirm this protocol to be a subscribeable
/// event with common + operator to register a handler that requires
/// converted information.
public struct TypedNotification<InfoType> {

    /// The represented notification name.
    let name: Notification.Name

    /// The converter to convert the information from the notification.
    let converter: InfoConverter<InfoType>
}

public struct Notifications {

    #if os(iOS)
    /// All keyboard related notifications.
    public typealias keyboard = KeyboardNotifications

    #endif
}

/// Subscribe with a handler to recive the information in the notification.
///
/// - Parameter left: the notification to subscribe
/// - Parameter right: the handler to receive the notification
/// - Returns: the subscription, a disposable object and make its life-cycle be same as the handler
func + <InfoType>(left: TypedNotification<InfoType>, right: @escaping TypedNotificationHandler<InfoType>) -> Subscription {
    let observer = NotificationCenter.default.addObserver(forName: left.name, object: nil, queue: .main) { notification in
        guard let info = left.converter(notification) else {
            return
        }
        right(info)
    }
    return Subscription {
        NotificationCenter.default.removeObserver(observer)
    }
}

/// Subscribe with a handler to recive the notification.
///
/// - Parameter left: the notification to subscribe
/// - Parameter right: the handler to receive the notification
/// - Returns: the subscription, a disposable object and make its life-cycle be same as the handler
func + (left: NamedNotification, right: @escaping SimpleNotificationHandler) -> Subscription {
    let observer = NotificationCenter.default.addObserver(forName: left.name, object: nil, queue: .main) { notification in
        right()
    }
    return Subscription {
        NotificationCenter.default.removeObserver(observer)
    }
}
