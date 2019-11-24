//
//  DisposableTests.swift
//  TypedNotification
//
//  Created by Spirit on 2019/11/24.
//  Copyright © 2019 Spirit. All rights reserved.
//

import XCTest
import Nimble

@testable import TypedNotification

final class DisposableTests: XCTestCase {

    func testDisposable() {
        var disposed = false
        var testee: Disposable? = Disposable {
            disposed = true
        }
        expect(testee).notTo(beNil())
        expect(disposed).to(beFalse())
        testee = nil
        expect(disposed).to(beTrue())
    }
}
