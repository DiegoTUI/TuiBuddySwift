//
//  AppDelegate.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 07/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // make NotificationManager RegionManager's delegate
        RegionManager.sharedInstance.delegate = NotificationManager.sharedInstance
        // start reachability
        ReachabilityManager.sharedInstance
        // Register protocol for caching
        //NSURLProtocol.registerClass(RNCachingURLProtocol.self)
        // register for local notifications (iOS8 only)
        if UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        println("Entered background.")
        /*var localNotification = UILocalNotification()
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = "holy crap!!"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)*/
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        // clear notifications in NotificationManager
        NotificationManager.sharedInstance.resetLocalNotifications()
        // handle notification
        var visibleViewController = NotificationManager.visibleViewController()
        if let notificationHandler = visibleViewController as? NotificationHandler {
            let id: Int32 = Int32((notification.userInfo!["id"] as String).toInt()!)
            let name: String = notification.userInfo!["name"] as String
            let latitude: Double = (notification.userInfo!["latitude"] as NSString).doubleValue
            let longitude: Double = (notification.userInfo!["longitude"] as NSString).doubleValue
            let radius: Double = (notification.userInfo!["radius"] as NSString).doubleValue
            let url: String = notification.userInfo!["url"] as String
            var attraction = Attraction(id: id, name: name, latitude: latitude, longitude: longitude, radius: radius, url: url)
            notificationHandler.handleNotificationForAttraction(attraction)
        }
    }
    
    // MARK: - Visible view controller
    
    /*func visibleViewController() -> (UIViewController?) {
        var rootViewController = self.window!.rootViewController
        // return nil if rootViewController is nil
        if rootViewController == nil {
            return nil
        }
        if rootViewController! is UINavigationController {
            return (rootViewController! as UINavigationController).visibleViewController
        }
        return rootViewController!
    }*/


}

