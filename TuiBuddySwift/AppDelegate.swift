//
//  AppDelegate.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 07/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
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
        var rootViewController = self.window!.rootViewController as UINavigationController
        var visibleViewController = rootViewController.visibleViewController
        var name = (notification.userInfo?["name"] as String)
        var url = (notification.userInfo?["url"] as String)
        if visibleViewController is AttractionInfoViewController {
            var name = notification.userInfo?["name"] as String
            (visibleViewController as AttractionInfoViewController).navigationTitle = name
            (visibleViewController as AttractionInfoViewController).url = url
            (visibleViewController as AttractionInfoViewController).reloadData()
        }
        else if visibleViewController is AttractionsTableViewController {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var attractionInfoViewController = mainStoryboard.instantiateViewControllerWithIdentifier("attractionInfo") as AttractionInfoViewController
        
            attractionInfoViewController.navigationTitle = name
            attractionInfoViewController.url = url
            rootViewController.pushViewController(attractionInfoViewController, animated: false)
        }
    }


}

