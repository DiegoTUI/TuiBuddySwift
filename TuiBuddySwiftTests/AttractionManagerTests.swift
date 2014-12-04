//
//  AttractionManagerTests.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 13/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation
import XCTest

class AttractionManagerTests: XCTestCase {
    
    var attractions = Array<Attraction>()
    
    override func setUp() {
        super.setUp()
        config.fakeCMS = "attractions_test"
        config.sqliteDbName = "attractions_test"
        CmsManager.sharedInstance.reloadCmsContents()
    }
    
    override func tearDown() {
        config.fakeCMS = "attractions"
        config.sqliteDbName = "attractions"
        super.tearDown()
    }
    
    func testReadAttractions() {
        AttractionManager.sharedInstance.reloadDb()
        attractions = AttractionManager.sharedInstance.readAttractions()
        XCTAssertEqual(attractions.count, 2, "did not read correct number of attractions from the database")
        let attraction1 = attractions[0]
        let attraction2 = attractions[1]
        // attraction1
        XCTAssertEqual(attraction1.id, "1", "wrong id for attraction1")
        XCTAssertEqual(attraction1.name, "attractionName_1", "wrong name for attraction1")
        XCTAssertEqual(attraction1.text, "attractionText_1", "wrong id for attraction1")
        XCTAssertEqual(attraction1.latitude, 2.0, "wrong latitude for attraction1")
        XCTAssertEqual(attraction1.longitude, 3.0, "wrong longitude for attraction1")
        XCTAssertEqual(attraction1.radius, 4.0, "wrong radius for attraction1")
        XCTAssertEqual(attraction1.thumbImageName, "thumb_1", "wrong thumbImageName for attraction1")
        XCTAssertEqual(attraction1.backgroundImageName, "background_1", "wrong backgroundImageName for attraction1")
        XCTAssertEqual(attraction1.facts.count, 3, "wrong number of facts for attraction1")
        XCTAssertEqual(attraction1.facts[0].id, "1", "wrong id for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[0].name, "factTitle_1_1", "wrong title for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[0].text, "factText_1_1", "wrong text for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[0].imageName, "fact_1_1", "wrong id for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[1].id, "2", "wrong id for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[1].name, "factTitle_1_2", "wrong title for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[1].text, "factText_1_2", "wrong text for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[1].imageName, "fact_1_2", "wrong id for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[2].id, "3", "wrong id for fact3 attraction1")
        XCTAssertEqual(attraction1.facts[2].name, "factTitle_1_3", "wrong title for fact3 attraction1")
        XCTAssertEqual(attraction1.facts[2].text, "factText_1_3", "wrong text for fact3 attraction1")
        XCTAssertEqual(attraction1.facts[2].imageName, "fact_1_3", "wrong id for fact3 attraction1")
        // attraction2
        XCTAssertEqual(attraction2.id, "2", "wrong id for attraction2")
        XCTAssertEqual(attraction2.name, "attractionName_2", "wrong name for attraction2")
        XCTAssertEqual(attraction2.text, "attractionText_2", "wrong id for attraction2")
        XCTAssertEqual(attraction2.latitude, 3.0, "wrong latitude for attraction2")
        XCTAssertEqual(attraction2.longitude, 4.0, "wrong longitude for attraction2")
        XCTAssertEqual(attraction2.radius, 5.0, "wrong radius for attraction2")
        XCTAssertEqual(attraction2.thumbImageName, "thumb_2", "wrong thumbImageName for attraction2")
        XCTAssertEqual(attraction2.backgroundImageName, "background_2", "wrong backgroundImageName for attraction2")
        XCTAssertEqual(attraction2.facts.count, 2, "wrong number of facts for attraction2")
        XCTAssertEqual(attraction2.facts[0].id, "1", "wrong id for fact1 attraction2")
        XCTAssertEqual(attraction2.facts[0].name, "factTitle_2_1", "wrong title for fact1 attraction2")
        XCTAssertEqual(attraction2.facts[0].text, "factText_2_1", "wrong text for fact1 attraction2")
        XCTAssertEqual(attraction2.facts[0].imageName, "fact_2_1", "wrong id for fact1 attraction2")
        XCTAssertEqual(attraction2.facts[1].id, "2", "wrong id for fact2 attraction2")
        XCTAssertEqual(attraction2.facts[1].name, "factTitle_2_2", "wrong title for fact2 attraction2")
        XCTAssertEqual(attraction2.facts[1].text, "factText_2_2", "wrong text for fact2 attraction2")
        XCTAssertEqual(attraction2.facts[1].imageName, "fact_2_2", "wrong id for fact2 attraction2")
    }
    
    func testUpdateAttractions() {
        attractions = AttractionManager.sharedInstance.readAttractions()
        // get first attraction
        var attraction1 = attractions[0]
        // change latitude, longitude and radius
        attraction1.latitude = 20.0
        attraction1.longitude = 30.0
        attraction1.radius = 40.0
        // update attraction
        AttractionManager.sharedInstance.updateAttraction(attraction1)
        // get attractions again
        attractions = AttractionManager.sharedInstance.readAttractions()
        // get first attraction
        attraction1 = attractions[0]
        // check that it was updated
        // attraction1
        XCTAssertEqual(attraction1.id, "1", "wrong id for attraction1")
        XCTAssertEqual(attraction1.name, "attractionName_1", "wrong name for attraction1")
        XCTAssertEqual(attraction1.text, "attractionText_1", "wrong id for attraction1")
        XCTAssertEqual(attraction1.latitude, 20.0, "wrong latitude for attraction1")
        XCTAssertEqual(attraction1.longitude, 30.0, "wrong longitude for attraction1")
        XCTAssertEqual(attraction1.radius, 40.0, "wrong radius for attraction1")
        XCTAssertEqual(attraction1.thumbImageName, "thumb_1", "wrong thumbImageName for attraction1")
        XCTAssertEqual(attraction1.backgroundImageName, "background_1", "wrong backgroundImageName for attraction1")
        XCTAssertEqual(attraction1.facts.count, 3, "wrong number of facts for attraction1")
        XCTAssertEqual(attraction1.facts[0].id, "1", "wrong id for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[0].name, "factTitle_1_1", "wrong title for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[0].text, "factText_1_1", "wrong text for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[0].imageName, "fact_1_1", "wrong id for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[1].id, "2", "wrong id for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[1].name, "factTitle_1_2", "wrong title for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[1].text, "factText_1_2", "wrong text for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[1].imageName, "fact_1_2", "wrong id for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[2].id, "3", "wrong id for fact3 attraction1")
        XCTAssertEqual(attraction1.facts[2].name, "factTitle_1_3", "wrong title for fact3 attraction1")
        XCTAssertEqual(attraction1.facts[2].text, "factText_1_3", "wrong text for fact3 attraction1")
        XCTAssertEqual(attraction1.facts[2].imageName, "fact_1_3", "wrong id for fact3 attraction1")
        // undo update for the next test
        attraction1.latitude = 2.0
        attraction1.longitude = 3.0
        attraction1.radius = 4.0
        // update attraction
        AttractionManager.sharedInstance.updateAttraction(attraction1)
        // get attractions again
        attractions = AttractionManager.sharedInstance.readAttractions()
        // get first attraction
        attraction1 = attractions[0]
        // check that everything is back to normal
        // attraction1
        XCTAssertEqual(attraction1.id, "1", "wrong id for attraction1")
        XCTAssertEqual(attraction1.name, "attractionName_1", "wrong name for attraction1")
        XCTAssertEqual(attraction1.text, "attractionText_1", "wrong id for attraction1")
        XCTAssertEqual(attraction1.latitude, 2.0, "wrong latitude for attraction1")
        XCTAssertEqual(attraction1.longitude, 3.0, "wrong longitude for attraction1")
        XCTAssertEqual(attraction1.radius, 4.0, "wrong radius for attraction1")
        XCTAssertEqual(attraction1.thumbImageName, "thumb_1", "wrong thumbImageName for attraction1")
        XCTAssertEqual(attraction1.backgroundImageName, "background_1", "wrong backgroundImageName for attraction1")
        XCTAssertEqual(attraction1.facts.count, 3, "wrong number of facts for attraction1")
        XCTAssertEqual(attraction1.facts[0].id, "1", "wrong id for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[0].name, "factTitle_1_1", "wrong title for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[0].text, "factText_1_1", "wrong text for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[0].imageName, "fact_1_1", "wrong id for fact1 attraction1")
        XCTAssertEqual(attraction1.facts[1].id, "2", "wrong id for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[1].name, "factTitle_1_2", "wrong title for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[1].text, "factText_1_2", "wrong text for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[1].imageName, "fact_1_2", "wrong id for fact2 attraction1")
        XCTAssertEqual(attraction1.facts[2].id, "3", "wrong id for fact3 attraction1")
        XCTAssertEqual(attraction1.facts[2].name, "factTitle_1_3", "wrong title for fact3 attraction1")
        XCTAssertEqual(attraction1.facts[2].text, "factText_1_3", "wrong text for fact3 attraction1")
        XCTAssertEqual(attraction1.facts[2].imageName, "fact_1_3", "wrong id for fact3 attraction1")
    }
    
}

