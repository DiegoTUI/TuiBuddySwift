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
    
    var shouldSendLocalNotification = false
    var attractionInNotification: Attraction? = nil
    var messageInNotification: String? = nil

    override func setUp() {
        super.setUp()
        // Mock scheduleLocalNotification
        NotificationManager._scheduleLocalNotification = {[unowned self](notification: UILocalNotification) -> Void in
            XCTAssertTrue(self.shouldSendLocalNotification, "sent local notification when it shouldn't")
            XCTAssertEqual(notification.alertBody!, self.messageInNotification!, "wrong message sent in notification")
            XCTAssertEqual(notification.userInfo!["name"] as String, self.attractionInNotification!.name, "wrong name sent in notification")
            XCTAssertEqual(notification.userInfo!["url"] as String, self.attractionInNotification!.url, "wrong url sent in notification")}
        
        NotificationManager.resetNotifications()
    }
    
    override func tearDown() {
        // return _scheduleLocalNotification to normal
        NotificationManager._scheduleLocalNotification = UIApplication.sharedApplication().scheduleLocalNotification
        super.tearDown()
    }

    func testBlockNotifications() {
        // test that the NotificationManager blocks notifications for the same attraction until reset
        var attraction1 = Attraction()
        attraction1.name = "name1"
        attraction1.url = "url1"
        var attraction2 = Attraction()
        attraction2.name = "name2"
        attraction2.url = "url2"
        // send notification for attraction1
        shouldSendLocalNotification = true
        messageInNotification = "message1"
        NotificationManager.sendLocalNotificationForAttraction(attraction1, withMessage: messageInNotification!)
    }
}
