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
        expect(KeyboardNotifications.willShow.name).to(equal(UIResponder.keyboardWillShowNotification))
        expect(KeyboardNotifications.willHide.name).to(equal(UIResponder.keyboardWillHideNotification))
        expect(KeyboardNotifications.didShow.name).to(equal(UIResponder.keyboardDidShowNotification))
        expect(KeyboardNotifications.didHide.name).to(equal(UIResponder.keyboardDidHideNotification))
        expect(KeyboardNotifications.willChange.name).to(equal(UIResponder.keyboardWillChangeFrameNotification))
        expect(KeyboardNotifications.didChange.name).to(equal(UIResponder.keyboardDidChangeFrameNotification))
    }
}

#endif
