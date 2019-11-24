//
//  KeyboardNotifications.swift
//  TypedNotification
//
//  Created by Spirit on 2019/11/7.
//  Copyright © 2019 Spirit. All rights reserved.
//

#if !os(macOS)

import UIKit

/// The keyboard information provided in Notification object
public struct KeyboardInfo {

    /// Identifies whether the keyboard belongs to the current app.
    /// With multitasking on iPad, all visible apps are notified when the keyboard
    /// appears and disappears. The value of this key is true for the app that caused
    /// the keyboard to appear and false for any other apps.
    let isLocal: Bool

    /// The starting frame rectangle of the keyboard in screen coordinates.
    /// The frame rectangle reflects the current orientation of the device.
    let beginFrame: CGRect

    /// The ending frame rectangle of the keyboard in screen coordinates.
    /// The frame rectangle reflects the current orientation of the device.
    let endFrame: CGRect

    /// The `UIView.AnimationCurve` constant that defines how the keyboard
    /// will be animated onto or off the screen.
    let animationCurve: UIView.AnimationCurve

    /// The duration of the animation in seconds.
    let animationDuration: TimeInterval
}

extension KeyboardInfo {

    /// Convert the notification to a `KeyboardInfo` object.
    ///
    /// - Parameter notification: the notification recevied from `NotificationCenter`
    /// - Returns: the keyboard info object; `nil` if the notification did contains the required values
    static func from(_ notification: Notification) -> KeyboardInfo? {
        guard let userInfo = notification.userInfo,
            let begin = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
            let end = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
            let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
            let curve =  UIView.AnimationCurve(rawValue: curveValue.intValue) else {
                return nil
        }
        let local = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber
        return KeyboardInfo(isLocal: local?.boolValue ?? true, beginFrame: begin.cgRectValue, endFrame: end.cgRectValue, animationCurve: curve, animationDuration: duration.doubleValue)
    }
}

public typealias KeyboardInfoHandler = (KeyboardInfo) -> ()

/// Define the keyboard notifications.
public enum KeyboardNotifications {

    /// Posted immediately prior to the display of the keyboard.
    case willShow

    /// Posted immediately prior to the dismissal of the keyboard.
    case willHide

    /// Posted immediately prior to a change in the keyboard’s frame.
    case willChange

    /// Posted immediately after the display of the keyboard.
    case didShow

    /// Posted immediately after the dismissal of the keyboard.
    case didHide

    /// Posted immediately after a change in the keyboard’s frame.
    case didChange
}

extension KeyboardNotifications: RawRepresentable {

    public typealias RawValue = Notification.Name

    public init?(rawValue: Notification.Name) {
        switch rawValue {
        case UIResponder.keyboardWillShowNotification:
            self = .willShow
        case UIResponder.keyboardWillHideNotification:
            self = .willHide
        case UIResponder.keyboardWillChangeFrameNotification:
            self = .willChange
        case UIResponder.keyboardDidShowNotification:
            self = .didShow
        case UIResponder.keyboardDidHideNotification:
            self = .didHide
        case UIResponder.keyboardDidChangeFrameNotification:
            self = .didChange
        default:
            return nil
        }
    }

    public var rawValue: Notification.Name {
        switch self {
        case .willShow:
            return UIResponder.keyboardWillShowNotification
        case .didShow:
            return UIResponder.keyboardDidShowNotification
        case .willChange:
            return UIResponder.keyboardWillChangeFrameNotification
        case .willHide:
            return UIResponder.keyboardWillHideNotification
        case .didHide:
            return UIResponder.keyboardDidHideNotification
        case .didChange:
            return UIResponder.keyboardDidChangeFrameNotification
        }
    }
}

extension KeyboardNotifications {

    /// Subscribe with a handler to recive the notification.
    ///
    /// - Parameter left: the notification to subscribe
    /// - Parameter right: the handler to receive the notification
    /// - Returns: the subscription, a disposable object and make its life-cycle be same as the handler
    static func + (left: KeyboardNotifications, right: @escaping KeyboardInfoHandler) -> Subscription {
        let observer = NotificationCenter.default.addObserver(forName: left.rawValue, object: nil, queue: .main) { notification in
            guard let info: KeyboardInfo = .from(notification) else {
                return
            }
            right(info)
        }
        return Subscription {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}

#endif
