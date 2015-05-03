# NKTouchID
NKTouchID is easy drop in solution for using Touch ID in your iPhone application using swift

Based on [Werbary/WBTouchID](https://github.com/Werbary/WBTouchID)

# Installation
1. Copy NKTouchID.swift to your project
2. Add LocalAuthentication.framework as optional dependency
3. Add touchID.reason key to Localizable.string table if you want (it is the text that will appear on Touch ID alert)
4. Call:
```swift
NKTouchID.authenticateWithTouchId(callback: { (success, error) in
  if success {
    println("Autheticated successfully");
  } else {
    println("Failed to authenticate: \(error!.localizedDescription)");
  }
})
```
Or if you want a better handling of the reason param

```swift
NKTouchID.authenticateWithTouchId(reason: "Custom reason", callback: { (success, error) in
  if success {
    println("Autheticated successfully");
  } else {
    println("Failed to authenticate: \(error!.localizedDescription)");
  }
})
```
