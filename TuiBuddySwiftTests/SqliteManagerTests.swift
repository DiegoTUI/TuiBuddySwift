//
//  SqliteManagerTests.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 13/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation
import XCTest

class SqliteManagerTests: XCTestCase {
    
    var attractions = Array<Attraction>()
    
    override func setUp() {
        super.setUp()
        attractions = SqliteManager.sharedInstance.readAttractions()
    }
    
    func testReadAttractions() {
        XCTAssertGreaterThan(countElements(attractions), 0, "did not read attractions from the database")
    }
    
    func testWriteDeleteAttractions() {
        var initialCount = countElements(attractions)
        var attraction = Attraction()
        attraction.name = "really_weird_test_attraction_name"
        SqliteManager.sharedInstance.writeAttraction(attraction)
        attractions = SqliteManager.sharedInstance.readAttractions()
        XCTAssertEqual(countElements(attractions), initialCount + 1, "did not write the attraction properly")
        // the inserted attraction should be the last
        let retrievedAttraction = attractions.last!
        XCTAssertEqual(retrievedAttraction.name, attraction.name, "did not recover the attraction properly")
        SqliteManager.sharedInstance.deleteAttraction(retrievedAttraction)
        attractions = SqliteManager.sharedInstance.readAttractions()
        XCTAssertEqual(countElements(attractions), initialCount, "did not delete the attraction properly")
    }
    

}

