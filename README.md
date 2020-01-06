# TypedNotification
[![Build Status](https://travis-ci.org/dbi1463/typed-notification.svg?branch=develop)](https://travis-ci.org/dbi1463/typed-notification)<!--[![codecov](https://codecov.io/gh/dbi1463/typed-notification/branch/develop/graph/badge.svg)](https://codecov.io/gh/dbi1463/typed-notification)-->
[![Swift Package Manager](https://img.shields.io/badge/SwiftPM-Compatiable-brightgreen.svg)](https://swift.org/package-manager/)
[![release](https://img.shields.io/github/release/dbi1463/typed-notification/all.svg)](https://github.com/dbi1463/typed-notification/releases)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

A type-safe way to receive notifications.

This library is inspired by
- **Typed Message** pattern described in *Pattern Hatching: Design Patterns Applied, Chapter 4*
- [Disposable pattern](https://en.wikipedia.org/wiki/Dispose_pattern)
- C# event delegate `+=` syntax.

With this library, it is able to register notification handlers that will receive type-safe information without writing boilerplate codes to decode notification `userInfo` object.

## Get Started

### Installation

Current, this library only supports Swift Package Manager. In `Package.swift`, add the following into `dependencies` array:

```swift
.package(url: "https://github.com/dbi1463/typed-notification.git", .branch("master"))
```

Next, add `TypedNotification` to your targets dependencies like:

```swift
.target(
    name: "[your target]",
    dependencies: [ "TypedNotification" ]
),
```

### Register an observer

To receive a type-safe notification is easy. All supported notifications are listed in `Notifications`. For example, to receive a keyboard will show notification, use the add operator (`+`) to subscribe the `Notifications.keyboard.willShow` notification.

```swift
let subscription = Notifications.keyboard.willShow + { [weak self] info in
    // info is a KeyboardInfo struct, can access the beginFrame, endFram, animation duration,
    // and animation curve like:
    // info.beginFrame, info.endFrame, ...
}
```

The registered handler will be invoked before the keyboard trying to show, and the information has been decoded as `KeyboardInfo` and pass to the handler. Note that the returned `subscription` should be kept, and in the closure, to access `self`, remember to add `[weak self]` to avoid reference cycle.

### Remove the observer

The returned subscription is a disposable object that will remove notification observer for you when itself has been deallocated. Thus, the only thing to do is to keep the subscription object as member data in the view controller (or the object that handles the notification). When the view controller disappeared (dellocated), the subscription will remove the observer automatically.

## License
**TypedNotification** is released under the MIT license. See [LICENSE](https://github.com/dbi1463/typed-notification/blob/master/LICENSE) for details.
