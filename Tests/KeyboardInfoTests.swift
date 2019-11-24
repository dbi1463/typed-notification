//
//  KeyboardInfoTests.swift
//  TypedNotification
//
//  Created by Spirit on 2019/11/24.
//  Copyright © 2019 Spirit. All rights reserved.
//

import XCTest
import Nimble

@testable import TypedNotification

#if !os(macOS)

final class KeyboardInfoTests: XCTestCase {

    func testFromNotificationWithoutUserInfo() {
        expect(KeyboardInfo.from(Notification(name: Notification.Name("any")))).to(beNil())
    }

    func testFromNotificationWithInsufficientUserInfo() {
        let notification = Notification(name: Notification.Name("any"), object: nil, userInfo: [
            UIResponder.keyboardAnimationDurationUserInfoKey: 0.25
        ]);
        expect(KeyboardInfo.from(notification)).to(beNil())
    }

    func testFromNotificationWithSufficientUserInfo() {
        let beginFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let endFrame = CGRect(x: 0, y: 125, width: 320, height: 120)
        let notification = Notification(name: Notification.Name("any"), object: nil, userInfo: [
            UIResponder.keyboardIsLocalUserInfoKey: NSNumber(booleanLiteral: false),
            UIResponder.keyboardAnimationDurationUserInfoKey: NSNumber(value: 0.25),
            UIResponder.keyboardFrameBeginUserInfoKey: NSValue(cgRect: beginFrame),
            UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: endFrame),
            UIResponder.keyboardAnimationCurveUserInfoKey: NSNumber(value: UIView.AnimationCurve.easeIn.rawValue)
        ]);
        let info = KeyboardInfo.from(notification)
        expect(info?.isLocal).to(beFalse())
        expect(info?.beginFrame).to(equal(beginFrame))
        expect(info?.endFrame).to(equal(endFrame))
        expect(info?.animationDuration).to(equal(0.25))
        expect(info?.animationCurve).to(equal(UIView.AnimationCurve.easeIn))
    }
}

#endif
