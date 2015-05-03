//
//  NKTouchID.swift
//  NKTouchIDDemo
//
//  Created by Nicos Belo Karalis on 5/3/15.
//  Copyright (c) 2015 Nicos Belo Karalis. All rights reserved.
//

import LocalAuthentication

let NKTouchIDErrorDomain = "NKTouchIDAuthenticationDomain";
let reasonKey = "touchID.reason2"
typealias TouchIDCallback = (Bool, NSError?) -> Void

class NKTouchID: NSObject {
  
  /**
  Checks if TouchID is available.
  
  :returns: true if the TouchID is available, false otherwise.
  */
  class func canUseTouchID() -> Bool {
    if let klass:AnyClass = NSClassFromString("LAContext") {
      let context = LAContext()
      return context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    return false
  }
  
  /**
  Authenticates a user with TouchID if TouchID is available using an explicit reason
  
  reason will be pulled from Localizable table with key "touchID.reason"
  
  :param: callback Reply block that is executed when authentication finishes.
  */
  class func authenticateWithTouchId(#callback: TouchIDCallback) {
     let reason : String = {
      var reason = NSLocalizedString(reasonKey, comment: "TouchID reason to be displayed")
      if reason == reasonKey {
        reason = "Tap to sign in"
      }
      return reason
    }()
    self.authenticateWithTouchId(reason: reason, callback: callback)
  }
  
  /**
  Authenticates a user with TouchID if TouchID is available
  
  :param: reason The reason that will be passed to TouchID internals
  
  :param: callback Reply block that is executed when authentication finishes.
  */
  class func authenticateWithTouchId(#reason: String, callback: TouchIDCallback) {
    println(reason)
    if !self.canUseTouchID() {
      callback(false, NSError(domain: NKTouchIDErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey:"Touch ID isn't availiable"]))
      return
    }
    
    let context = LAContext()
    context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: { (success, error) -> Void in
      dispatch_async(dispatch_get_main_queue(), {
        callback(success, error)
      })
    })
  }
}
