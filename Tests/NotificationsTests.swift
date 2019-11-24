//
//  NotificationsTests.swift
//  TypedNotification
//
//  Created by Spirit on 2019/11/24.
//  Copyright © 2019 Spirit. All rights reserved.
//

import XCTest
import Nimble

@testable import TypedNotification

final class NotificationsTests: XCTestCase {

    #if !os(macOS)
    func testKeyboard() {
        var notified = false
        var keyboardInfo: KeyboardInfo?
        var subscription: Subscription? = Notifications.keyboard.willShow + { info in
            notified = true
            keyboardInfo = info
        }
        expect(subscription).notTo(beNil())
        NotificationCenter.default.post(name: UIResponder.keyboardWillShowNotification, object: nil, userInfo: nil)
        expect(notified).to(beFalse())
        expect(keyboardInfo).to(beNil())

        NotificationCenter.default.post(name: UIResponder.keyboardWillShowNotification, object: nil, userInfo: self.mockKeyboardNotificationUserInfo())
        expect(notified).to(beTrue())
        expect(keyboardInfo).notTo(beNil())

        subscription = nil
        notified = false
        keyboardInfo = nil
        NotificationCenter.default.post(name: UIResponder.keyboardWillShowNotification, object: nil, userInfo: self.mockKeyboardNotificationUserInfo())
        expect(notified).to(beFalse())
        expect(keyboardInfo).to(beNil())
    }

    private func mockKeyboardNotificationUserInfo() -> [AnyHashable: Any] {
        return [
            UIResponder.keyboardIsLocalUserInfoKey: NSNumber(booleanLiteral: true),
            UIResponder.keyboardAnimationDurationUserInfoKey: NSNumber(value: 0.25),
            UIResponder.keyboardFrameBeginUserInfoKey: NSValue(cgRect: CGRect(x: 0, y: 0, width: 320, height: 0)),
            UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: CGRect(x: 0, y: 200, width: 230, height: 100)),
            UIResponder.keyboardAnimationCurveUserInfoKey: NSNumber(value: UIView.AnimationCurve.easeIn.rawValue)
        ]
    }
    #endif
}
