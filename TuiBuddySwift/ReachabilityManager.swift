//
//  ReachabilityManager.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente Garcia on 18/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation

class ReachabilityManager {
    
    var isInternetReachable:Bool? = nil
    
    // MARK: - Shared instance
    
    class var sharedInstance: ReachabilityManager {
        struct Static {
            static var instance: ReachabilityManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ReachabilityManager()
        }
        
        return Static.instance!
    }
    
    // MARK: - Initialization
    
    init() {
        var reachability = Reachability.reachabilityForInternetConnection()
        isInternetReachable = reachability.currentReachabilityStatus() != .NotReachable
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("reachabilityChanged:"), name:kReachabilityChangedNotification, object:nil)
        reachability.startNotifier()
    }
    
    // MARK: - Capture changes in reachability
    @objc func reachabilityChanged(notification: NSNotification) {
        println("Reachability changed")
        if (notification.object as! Reachability).currentReachabilityStatus() == .NotReachable {
            println("Internet not reachable")
            isInternetReachable = false
        }
        else {
            println("Internet reachable")
            isInternetReachable = true
        }
    }
}