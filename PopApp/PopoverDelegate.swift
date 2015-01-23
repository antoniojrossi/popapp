//
//  PopoverDelegate.swift
//  PopApp
//
//  Created by Antonio J Rossi on 22/1/15.
//  Copyright (c) 2015 Antonio J Rossi. All rights reserved.
//

import Foundation

class PopoverDelegate: NSObject, NSPopoverDelegate {
    
    var willShowClosure: Closure?
    var didShowClosure: Closure?
    var willCloseClosure: Closure?
    var didCloseClosure: Closure?
    
    func popoverWillShow(notification: NSNotification) {
        willShowClosure?()
    }
    
    func popoverWillClose(notification: NSNotification) {
        willCloseClosure?()
    }
    
    func popoverDidShow(notification: NSNotification) {
        didShowClosure?()
    }
    
    func popoverDidClose(notification: NSNotification) {
        didCloseClosure?()
    }
    
}