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

fileprivate func wrap(_ name: Notification.Name) -> TypedNotification<KeyboardInfo> {
    return TypedNotification<KeyboardInfo>(name: name) { .from($0) }
}

/// Define the keyboard notifications.
public struct KeyboardNotifications {

    /// Posted immediately prior to the display of the keyboard.
    static let willShow = wrap(UIResponder.keyboardWillShowNotification)

    /// Posted immediately prior to the dismissal of the keyboard.
    static let  willHide = wrap(UIResponder.keyboardWillHideNotification)

    /// Posted immediately prior to a change in the keyboard’s frame.
    static let  willChange = wrap(UIResponder.keyboardWillChangeFrameNotification)

    /// Posted immediately after the display of the keyboard.
    static let  didShow = wrap(UIResponder.keyboardDidShowNotification)

    /// Posted immediately after the dismissal of the keyboard.
    static let  didHide = wrap(UIResponder.keyboardDidHideNotification)

    /// Posted immediately after a change in the keyboard’s frame.
    static let  didChange = wrap(UIResponder.keyboardDidChangeFrameNotification)
}

#endif
