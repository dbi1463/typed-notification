//
//  KeyboardNotificationsTests.swift
//  TypedNotification
//
//  Created by Spirit on 2019/11/24.
//  Copyright © 2019 Spirit. All rights reserved.
//

import Foundation

import XCTest
import Nimble

@testable import TypedNotification

#if !os(macOS)

final class KeyboardNotificationsTests: XCTestCase {

    func testRawValue() {
        expect(KeyboardNotifications.willShow.rawValue).to(equal(UIResponder.keyboardWillShowNotification))
        expect(KeyboardNotifications.willHide.rawValue).to(equal(UIResponder.keyboardWillHideNotification))
        expect(KeyboardNotifications.didShow.rawValue).to(equal(UIResponder.keyboardDidShowNotification))
        expect(KeyboardNotifications.didHide.rawValue).to(equal(UIResponder.keyboardDidHideNotification))
        expect(KeyboardNotifications.willChange.rawValue).to(equal(UIResponder.keyboardWillChangeFrameNotification))
        expect(KeyboardNotifications.didChange.rawValue).to(equal(UIResponder.keyboardDidChangeFrameNotification))
    }

    func testInit() {
        expect(KeyboardNotifications(rawValue: UIResponder.keyboardWillShowNotification)).to(equal(KeyboardNotifications.willShow))
        expect(KeyboardNotifications(rawValue: UIResponder.keyboardWillHideNotification)).to(equal(KeyboardNotifications.willHide))
        expect(KeyboardNotifications(rawValue: UIResponder.keyboardDidShowNotification)).to(equal(KeyboardNotifications.didShow))
        expect(KeyboardNotifications(rawValue: UIResponder.keyboardDidHideNotification)).to(equal(KeyboardNotifications.didHide))
        expect(KeyboardNotifications(rawValue: UIResponder.keyboardWillChangeFrameNotification)).to(equal(KeyboardNotifications.willChange))
        expect(KeyboardNotifications(rawValue: UIResponder.keyboardDidChangeFrameNotification)).to(equal(KeyboardNotifications.didChange))
        expect(KeyboardNotifications(rawValue: Notification.Name("unknown"))).to(beNil())
    }
}

#endif
