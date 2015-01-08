//
//  PopApp.swift
//  PopApp
//
//  Created by Antonio J Rossi on 24/12/14.
//  Copyright (c) 2014 Antonio J Rossi. All rights reserved.
//

import Cocoa

public class PopApp: NSObject {
   
    let statusBarItem: NSStatusItem
    let popover: NSPopover = NSPopover()
    public var viewController: NSViewController? {
        didSet{
            self.popover.contentViewController = viewController
        }
    }
    
    public init(icon: NSImage) {
        self.statusBarItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
        super.init()
        setupStatusBarItemWith(icon)
        self.popover.behavior = NSPopoverBehavior.Transient
    }
    
    func clicked() {
        if popover.contentViewController != nil {
            show()
        }
    }
    
    func show() {
        NSApplication.sharedApplication().activateIgnoringOtherApps(true)
        if let button = statusBarItem.button{
            popover.showRelativeToRect(button.frame, ofView: button, preferredEdge:1)
        }
    }
    
    func setupStatusBarItemWith(icon: NSImage) {
        icon.setTemplate(true)
        self.statusBarItem.button?.image = icon
        self.statusBarItem.target = self
        self.statusBarItem.action = "clicked"
    }
    
}