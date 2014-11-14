//
//  NotificationManagerTests.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 13/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit
import XCTest

class NotificationManagerTests: XCTestCase {
    
    var attractionInNotification: Attraction? = nil
    var messageInNotification: String? = nil
    var notificationsReceived: Dictionary<Int32, Int>? = nil
    
    func handleLocalNotification (notification: UILocalNotification) {
        XCTAssertEqual(notification.alertBody!, messageInNotification!, "wrong message sent in notification")
        XCTAssertEqual(notification.userInfo!["name"] as String, attractionInNotification!.name, "wrong name sent in notification")
        XCTAssertEqual(notification.userInfo!["url"] as String, attractionInNotification!.url, "wrong url sent in notification")
        
        notificationsReceived![attractionInNotification!.id]!++
    }

    override func setUp() {
        super.setUp()
        // Mock scheduleLocalNotification
        NotificationManager._scheduleLocalNotification = handleLocalNotification
        
        NotificationManager.resetNotifications()
    }
    
    override func tearDown() {
        // return _scheduleLocalNotification to normal
        NotificationManager._scheduleLocalNotification = UIApplication.sharedApplication().scheduleLocalNotification
        super.tearDown()
    }

    func testBlockNotifications() {
        // test that the NotificationManager blocks notifications for the same attraction until reset
        // init attractions
        var attraction1 = Attraction()
        attraction1.name = "name1"
        attraction1.url = "url1"
        var attraction2 = Attraction()
        attraction2.id = -2
        attraction2.name = "name2"
        attraction2.url = "url2"
        // function to check the number of notifications received
        func attractionsShouldHaveReceived(notifications1: Int, notifications2: Int) {
            XCTAssertEqual(notificationsReceived![attraction1.id]!, notifications1, "wrong number of notifications received for attraction 1")
            XCTAssertEqual(notificationsReceived![attraction2.id]!, notifications2, "wrong number of notifications received for attraction 2")
        }
        // init notifications received
        notificationsReceived = [attraction1.id: 0, attraction2.id: 0]
        // send notification for attraction1
        attractionInNotification = attraction1
        messageInNotification = "message1"
        NotificationManager.sendLocalNotificationForAttraction(attraction1, withMessage: messageInNotification!)
        attractionsShouldHaveReceived(1, 0)
        // send a hundred more notifications for attraction1
        for i in 1...100 {
            NotificationManager.sendLocalNotificationForAttraction(attraction1, withMessage: messageInNotification!)
        }
        attractionsShouldHaveReceived(1, 0)
        // send notification for attraction2
        attractionInNotification = attraction2
        messageInNotification = "message2"
        NotificationManager.sendLocalNotificationForAttraction(attraction2, withMessage: messageInNotification!)
        attractionsShouldHaveReceived(1, 1)
        // send a hundred more notifications for attraction2
        for i in 1...100 {
            NotificationManager.sendLocalNotificationForAttraction(attraction2, withMessage: messageInNotification!)
        }
        attractionsShouldHaveReceived(1, 1)
        // reset notifications (unlock the phone)
        NotificationManager.resetNotifications()
        // send notification2 again
        NotificationManager.sendLocalNotificationForAttraction(attraction2, withMessage: messageInNotification!)
        attractionsShouldHaveReceived(1, 2)
    }
}
