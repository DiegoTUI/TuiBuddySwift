//
//  NotificationManager.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 13/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class NotificationManager {
    
    private struct _private_struct {
        static var notifications = Dictionary<Int32, Bool>()
        static var scheduleLocalNotification = UIApplication.sharedApplication().scheduleLocalNotification
    }
    
    private class var _notifications: Dictionary<Int32, Bool> {
        get {return _private_struct.notifications}
        set {_private_struct.notifications = newValue}
    }
    
    public class var _scheduleLocalNotification: (UILocalNotification) -> Void {
        get {return _private_struct.scheduleLocalNotification}
        set {_private_struct.scheduleLocalNotification = newValue}
    }
    
    class func resetNotifications() {
        _notifications = Dictionary<Int32, Bool>()
    }
    
    class func sendLocalNotificationForAttraction(attraction: Attraction, withMessage message: String) {
        // send local notification if not sent
        if _notifications[attraction.id] != nil && !_notifications[attraction.id]! {
            var localNotification = UILocalNotification()
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = message
            localNotification.userInfo = ["name":attraction.name,
                "url":attraction.url]
            _scheduleLocalNotification(localNotification)
        }
    }

}
