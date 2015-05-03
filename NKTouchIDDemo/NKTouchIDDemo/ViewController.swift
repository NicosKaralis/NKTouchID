//
//  ViewController.swift
//  NKTouchIDDemo
//
//  Created by Nicos Belo Karalis on 5/3/15.
//  Copyright (c) 2015 Nicos Belo Karalis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func loginWithReason(sender: AnyObject) {
    if NKTouchID.canUseTouchID() {
      NKTouchID.authenticateWithTouchId(reason: "Custom Tap to sign in", callback: { (success, error) in
        println("Callback executed: \(success) : \(error)")
      })
    } else {
      println("TouchID not available")
    }
  }
  
  @IBAction func loginWIthOutReason(sender: AnyObject) {
    if NKTouchID.canUseTouchID() {
      NKTouchID.authenticateWithTouchId(callback: { (success, error) in
        println("Callback executed: \(success) : \(error)")
      })
    } else {
      println("TouchID not available")
    }
  }
}

