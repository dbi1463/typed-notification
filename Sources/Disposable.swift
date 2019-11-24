//
//  Disposable.swift
//  TypedNotification
//
//  Created by Spirit on 2019/11/7.
//  Copyright © 2019 Spirit. All rights reserved.
//

import Foundation

typealias Dispose = () -> ()

final public class Disposable {

    private let dispose: Dispose

    /// Construct a disposable object with the handler that dispose allocated resources.
    ///
    /// - Parameter dispose: the handler to dispose allocated resources
    init(_ dispose: @escaping Dispose) {
        self.dispose = dispose
    }

    deinit {
        self.dispose()
    }
}
