# NotificationValues

Send and receive typed values with [`NotificationCenter`](https://developer.apple.com/documentation/foundation/notificationcenter).

## Overview

This framework provides methods for dealing with strongly typed values in `NotificationCenter`. To begin sending values, create a `NotificationKey`, which will define the type of your notification's values:

```swift
enum AuthStateKey: NotificationKey {
    typealias Value = AuthState
    static let name = Notification.Name("AuthStateNotification")
}
```

Once a key has been created, you can send values to the notification center using the `post(_:for:)` method:

```swift
NotificationCenter.default.post(.authenticated(user), for: AuthStateKey.self)
```

Elsewhere, the key can be used to receive values from the notification center. For example, to receive values as an asynchronous sequence:

```swift
let center = NotificationCenter.default

for await authState in center.values(for: AuthStateKey.self) {
    switch authState {
    case .authenticated(let user):
        print("Authenticated: \(user.id)")
    case .unauthenticated:
        print("Unauthenticated")
    }
}
```

It is also possible to receive the values with a Combine publisher:

```swift
NotificationCenter.default
    .valuesPublisher(for: AuthStateKey.self)
    .map { authState in
        guard case .authenticated(let user) = state
        else { return nil }
    
        return user
    }
    .assign(to: &$currentUser)
```
