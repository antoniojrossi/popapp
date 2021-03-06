//
//  PopApp.swift
//  PopApp
//
//  Created by Antonio J Rossi on 24/12/14.
//  Copyright (c) 2014 Antonio J Rossi. All rights reserved.
//

import Cocoa

public typealias Closure = () -> ()

public class PopApp: NSObject, NSPopoverDelegate {
   
    let statusBarItem: NSStatusItem
    let popover = NSPopover()
    let delegate = PopoverDelegate()
    var popoverTransiencyMonitor: NSEvent?
    public var isVisible: Bool {
        return popover.shown
    }
    public var isEnabled: Bool {
        if let buttonStatus = self.statusBarItem.button?.enabled {
            return buttonStatus
        }
        return false
    }
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
        self.popover.delegate = self.delegate
    }
    
    public func disable() {
        self.statusBarItem.button?.appearsDisabled = true
        self.statusBarItem.button?.enabled = false
    }
    
    public func enable() {
        self.statusBarItem.button?.appearsDisabled = false
        self.statusBarItem.button?.enabled = true
    }
    
    public func willShow(closure: Closure) {
        self.delegate.willShowClosure = closure
    }
    
    public func didShow(closure: Closure) {
        self.delegate.didShowClosure = closure
    }
    
    public func willClose(closure: Closure) {
        self.delegate.willCloseClosure = closure
    }
    
    public func didClose(closure: Closure) {
        self.delegate.didCloseClosure = closure
    }
    
    func clicked() {
        show()
        if self.popoverTransiencyMonitor == nil {
            self.popoverTransiencyMonitor = NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.LeftMouseDownMask | NSEventMask.RightMouseDownMask) { event in
                if self.popoverTransiencyMonitor != nil {
                    NSEvent.removeMonitor(self.popoverTransiencyMonitor!)
                    self.popoverTransiencyMonitor = nil;
                }
                self.popover.close()
            } as? NSEvent
        }
    }
    
    func show() {
        NSApplication.sharedApplication().activateIgnoringOtherApps(true)
        if let button = statusBarItem.button {
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