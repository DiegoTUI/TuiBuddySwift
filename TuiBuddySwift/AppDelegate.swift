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
        NSURLProtocol.registerClass(RNCachingURLProtocol.self)
        // set up notifications
        setupNotifications(application)
        // change NavigationBar style for all navigation bars
        UINavigationBar.appearance().barTintColor = kSandColor
        UINavigationBar.appearance().tintColor = kDarkBlueColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont(name: kBoldFont, size: CGFloat(kH1FontSize))!,
            NSForegroundColorAttributeName: kDarkBlueColor
        ]
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
        if config.debug {
            NotificationManager.sharedInstance.didEnterRegion("1")
        }
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
        handleLocalNotification(notification)
    }
    
    // MARK: - Handle actions from notifications
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        if (identifier == kOpenNowActionIdentifier) {
            handleLocalNotification(notification)
        }
        completionHandler()
    }
    
    // MARK: - Setup notifications
    
    func setupNotifications(application: UIApplication) {
        // create actions
        // open now
        var openNowAction = UIMutableUserNotificationAction()
        openNowAction.identifier = kOpenNowActionIdentifier
        openNowAction.title = kOpenNowActionTitle
        openNowAction.activationMode = .Foreground
        openNowAction.destructive = false
        openNowAction.authenticationRequired = false
        // look later
        var lookLaterAction = UIMutableUserNotificationAction()
        lookLaterAction.identifier = kLookLaterActionIdentifier
        lookLaterAction.title = kLookLaterActionTitle
        lookLaterAction.activationMode = .Background
        lookLaterAction.destructive = false
        lookLaterAction.authenticationRequired = false
        // notification category
        var notificationCategory = UIMutableUserNotificationCategory()
        notificationCategory.identifier = kNotificationCategoryIdentifier
        notificationCategory.setActions([openNowAction, lookLaterAction], forContext: .Default)
        notificationCategory.setActions([openNowAction, lookLaterAction], forContext: .Minimal)
        // register for local notifications (iOS8 only)
        var categories = NSSet(object: notificationCategory)
        if UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:")) {
            println("registerring user notification settings")
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: categories as Set<NSObject>))
        }
    }
    
    // MARK: Handle notification
    
    func handleLocalNotification(notification: UILocalNotification) {
        // clear notifications in NotificationManager
        NotificationManager.sharedInstance.resetLocalNotifications()
        // handle notification
        var visibleViewController = NotificationManager.visibleViewController()
        if let notificationHandler = visibleViewController as? NotificationHandler {
            let archivedAttraction = notification.userInfo!["attraction"] as! NSData
            let attraction: Attraction = NSKeyedUnarchiver.unarchiveObjectWithData(archivedAttraction) as! Attraction
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

