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
    
    func testWriteUpdateDeleteAttractions() {
        var initialCount = countElements(attractions)
        // create attraction
        var attraction = Attraction()
        attraction.name = "really_weird_test_attraction_name"
        // write in DB
        SqliteManager.sharedInstance.writeAttraction(attraction)
        attractions = SqliteManager.sharedInstance.readAttractions()
        XCTAssertEqual(countElements(attractions), initialCount + 1, "did not write the attraction properly")
        // the inserted attraction should be the last
        var retrievedAttraction = attractions.last!
        XCTAssertEqual(retrievedAttraction.name, attraction.name, "did not recover the attraction properly")
        // change and update attraction
        retrievedAttraction.name = "yet_another_really_weird_test_attraction_name"
        SqliteManager.sharedInstance.updateAttraction(retrievedAttraction)
        attractions = SqliteManager.sharedInstance.readAttractions()
        XCTAssertEqual(countElements(attractions), initialCount + 1, "updating changed the number of attractions in the db")
        // id shouldn't have changed
        let updatedAttraction = attractions.filter({$0.id == retrievedAttraction.id})[0]
        XCTAssertEqual(updatedAttraction.name, retrievedAttraction.name, "did not update the attraction correctly")
        // delete attraction
        SqliteManager.sharedInstance.deleteAttraction(updatedAttraction)
        attractions = SqliteManager.sharedInstance.readAttractions()
        XCTAssertEqual(countElements(attractions), initialCount, "did not delete the attraction properly")
    }
    

}

