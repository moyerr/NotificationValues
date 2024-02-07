# ``NotificationValues``

Send and receive typed values with `NotificationCenter`.

## Overview

The ``NotificationValues`` framework provides methods for dealing with strongly typed values in `NotificationCenter`. To begin sending values, create a ``NotificationKey``, which will define the type of your notification's values:

```swift
enum AuthStateKey: NotificationKey {
    typealias Value = AuthState
    static let name = Notification.Name("AuthStateNotification")
}
```

Once a key has been created, you can send values to the notification center using the ``Foundation/NotificationCenter/post(_:for:)`` method:

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

## Topics

### Defining a Notification Key
- ``NotificationKey``

### Posting Values
- ``Foundation/NotificationCenter/post(_:for:)``
- ``Foundation/NotificationCenter/post(for:)``

### Receiving Values as an Asynchronous Sequence
- ``Foundation/NotificationCenter/values(for:)``
- ``Foundation/NotificationCenter/Values``

### Receiving Values as a Combine Publisher
- ``Foundation/NotificationCenter/valuesPublisher(for:)``
- ``Foundation/NotificationCenter/ValuesPublisher``
