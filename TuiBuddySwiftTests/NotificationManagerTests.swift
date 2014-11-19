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
    
    var attraction1 = Attraction()
    var attraction2 = Attraction()
    var attractionInNotification: Attraction? = nil
    var messageInNotification: String? = nil
    var notificationsReceived: Dictionary<Int32, Int>? = nil
    var mockNotificationHandler = MockNotificationHandler()
    
    func handleLocalNotification (notification: UILocalNotification) {
        XCTAssertEqual(notification.alertBody!, messageInNotification!, "wrong message sent in notification")
        // unarchive attraction
        let archivedAttraction = notification.userInfo!["attraction"] as NSData
        let attraction: Attraction = NSKeyedUnarchiver.unarchiveObjectWithData(archivedAttraction) as Attraction
        XCTAssertEqual(attraction.id, attractionInNotification!.id, "wrong id sent in notification")
        XCTAssertEqual(attraction.name, attractionInNotification!.name, "wrong name sent in notification")
        XCTAssertEqual(attraction.latitude, attractionInNotification!.latitude, "wrong latitude sent in notification")
        XCTAssertEqual(attraction.longitude, attractionInNotification!.latitude, "wrong longitude sent in notification")
        XCTAssertEqual(attraction.radius, attractionInNotification!.radius, "wrong longitude sent in notification")
        XCTAssertEqual(attraction.url, attractionInNotification!.url, "wrong url sent in notification")
        
        notificationsReceived![attractionInNotification!.id]!++
    }
    
    class MockNotificationHandler: UIViewController, NotificationHandler {
        var master: NotificationManagerTests? = nil
        var shouldShow = true
        
        override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
            var alert = viewControllerToPresent as UIAlertController
            XCTAssertEqual(alert.message!, master!.messageInNotification!, "wrong message in AlertController")
            master!.notificationsReceived![master!.attractionInNotification!.id]!++
        }
        
        func handleNotificationForAttraction(attraction: Attraction) {
        }
    }

    override func setUp() {
        super.setUp()
        // init attractions
        attraction1.name = "name1"
        attraction1.url = "url1"
        attraction2.id = -2
        attraction2.name = "name2"
        attraction2.url = "url2"
        // init notifications received
        notificationsReceived = [attraction1.id: 0, attraction2.id: 0]
        // Mock scheduleLocalNotification
        NotificationManager.sharedInstance._scheduleLocalNotification = handleLocalNotification
        // Mock visibleViewController class method
        NotificationManager.sharedInstance._visibleViewController = {[unowned self]()->UIViewController? in
            self.mockNotificationHandler.master = self
            return self.mockNotificationHandler}
        // reset local notifications
        NotificationManager.sharedInstance.resetLocalNotifications()
    }
    
    override func tearDown() {
        // return _scheduleLocalNotification to normal
        NotificationManager.sharedInstance._scheduleLocalNotification = UIApplication.sharedApplication().scheduleLocalNotification
        // return _visibleViewController to normal
        NotificationManager.sharedInstance._visibleViewController = NotificationManager.visibleViewController
        super.tearDown()
    }
    
    // function to check the number of notifications received
    func attractionsShouldHaveReceived(notifications1: Int, _ notifications2: Int) {
        XCTAssertEqual(notificationsReceived![attraction1.id]!, notifications1, "wrong number of notifications received for attraction 1")
        XCTAssertEqual(notificationsReceived![attraction2.id]!, notifications2, "wrong number of notifications received for attraction 2")
    }
    
    func testAlertViews() {
        // trigger alert with attraction 1
        attractionInNotification = attraction1
        messageInNotification = "message1"
        NotificationManager.sharedInstance._triggerAlertViewForAttraction(attractionInNotification!, withMessage: messageInNotification!)
        attractionsShouldHaveReceived(1, 0)
        // trigger alert with attraction2. Should not show since the other alert has not been "closed"
        attractionInNotification = attraction2
        messageInNotification = "message2"
        NotificationManager.sharedInstance._triggerAlertViewForAttraction(attractionInNotification!, withMessage: messageInNotification!)
        attractionsShouldHaveReceived(1, 0)
        // "close" alert
        mockNotificationHandler.shouldShow = true
        // relaunch alert. Now it should receive it
        NotificationManager.sharedInstance._triggerAlertViewForAttraction(attractionInNotification!, withMessage: messageInNotification!)
        attractionsShouldHaveReceived(1, 1)
    }

    func testLocalNotifications() {
        // test that the NotificationManager blocks notifications for the same attraction until reset
        // send notification for attraction1
        attractionInNotification = attraction1
        messageInNotification = "message1"
        NotificationManager.sharedInstance._sendLocalNotificationForAttraction(attractionInNotification!, withMessage: messageInNotification!)
        attractionsShouldHaveReceived(1, 0)
        // send a hundred more notifications for attraction1
        for i in 1...100 {
            NotificationManager.sharedInstance._sendLocalNotificationForAttraction(attractionInNotification!, withMessage: messageInNotification!)
        }
        attractionsShouldHaveReceived(1, 0)
        // send notification for attraction2
        attractionInNotification = attraction2
        messageInNotification = "message2"
        NotificationManager.sharedInstance._sendLocalNotificationForAttraction(attractionInNotification!, withMessage: messageInNotification!)
        attractionsShouldHaveReceived(1, 1)
        // send a hundred more notifications for attraction2
        for i in 1...100 {
            NotificationManager.sharedInstance._sendLocalNotificationForAttraction(attractionInNotification!, withMessage: messageInNotification!)
        }
        attractionsShouldHaveReceived(1, 1)
        // reset notifications (unlock the phone)
        NotificationManager.sharedInstance.resetLocalNotifications()
        // send notification2 again
        NotificationManager.sharedInstance._sendLocalNotificationForAttraction(attractionInNotification!, withMessage: messageInNotification!)
        attractionsShouldHaveReceived(1, 2)
    }
}
