//
//  NotificationManager.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 13/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

@objc protocol NotificationHandler {
    var shouldShow: Bool {get set}
    
    func handleNotificationForAttraction(attraction: Attraction)
}

class NotificationManager: RegionManagerDelegate {
    
    var _localNotifications = Dictionary<Int32, Bool>()
    var _scheduleLocalNotification = UIApplication.sharedApplication().scheduleLocalNotification
    var _visibleViewController = NotificationManager.visibleViewController
    
    // MARK: - Shared instance
    
    class var sharedInstance: NotificationManager {
        struct Static {
            static var instance: NotificationManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = NotificationManager()
        }
        
        return Static.instance!
    }
    
    // MARK: - RegionManagerDelegate
    
    func didEnterRegion(attractionId: Int32) {
        println("Entered region: \(attractionId)")
        // find attraction
        let attraction = AttractionManager.sharedInstance.readAttractions().filter({$0.id == attractionId})[0]
        let message = "Check out these cool facts about \(attraction.name)!!"
        // check if the app is in background or foreground
        if UIApplication.sharedApplication().applicationState == .Background {
            // Background: trigger local notification
            _sendLocalNotificationForAttraction(attraction, withMessage: message)
        }
        else if config.showAlerts {
            // Foreground: trigger alert view
            _triggerAlertViewForAttraction(attraction, withMessage: message)
        }
    }
    
    
    func resetLocalNotifications() {
        _localNotifications = Dictionary<Int32, Bool>()
    }
    
    func _triggerAlertViewForAttraction(attraction: Attraction, withMessage message: String) {
        // get visible view controller
        var visibleViewController = _visibleViewController()
        //var visibleViewController = Util.visibleViewController()
        // only trigger the alert if the viewController can handle it
        if let notificationHandler = visibleViewController as? NotificationHandler {
            if notificationHandler.shouldShow {
                println("triggering alert with message: \(message)")
                var alert = UIAlertController(title: "Hey!!", message: message, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "No, thanks", style: .Cancel, handler: {action in
                    notificationHandler.shouldShow = true}))
                alert.addAction(UIAlertAction(title: "OK!!", style: .Default, handler:{action in
                    notificationHandler.handleNotificationForAttraction(attraction)
                    notificationHandler.shouldShow = true}))
                visibleViewController?.presentViewController(alert, animated: true, completion: nil)
                notificationHandler.shouldShow = false
            }
        }
    }
    
    class func visibleViewController() -> (UIViewController?) {
        var rootViewController = UIApplication.sharedApplication().delegate?.window??.rootViewController
        // return nil if rootViewController is nil
        if rootViewController == nil {
            return nil
        }
        if rootViewController! is UINavigationController {
            return (rootViewController! as UINavigationController).visibleViewController
        }
        return rootViewController!
    }
    
    func _sendLocalNotificationForAttraction(attraction: Attraction, withMessage message: String) {
        // send local notification if not sent
        if _localNotifications[attraction.id] == nil || _localNotifications[attraction.id]! == false {
            var localNotification = UILocalNotification()
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = message
            // serialize the attraction using a NSKeyedArchiver
            let archivedAttraction = NSKeyedArchiver.archivedDataWithRootObject(attraction)
            localNotification.userInfo = ["attraction": archivedAttraction]
            // set the attraction as notified
            _localNotifications[attraction.id] = true
            // schedule notification
            _scheduleLocalNotification(localNotification)
        }
    }

}
