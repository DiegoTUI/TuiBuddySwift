//
//  AttractionTests.swift
//  
//
//  Created by Diego Lafuente Garcia on 19/11/14.
//
//

import Foundation
import XCTest

class AttractionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        let attraction = Attraction(id: "53", name: "testName", text: "testText", latitude: 1.0, longitude: 2.0, radius: 3.0, facts: [])
        XCTAssertEqual(attraction.id, "53", "id not properly initialized")
        XCTAssertEqual(attraction.name, "testName", "name not properly initialized")
        XCTAssertEqual(attraction.text, "testText", "text not properly initialized")
        XCTAssertEqual(attraction.latitude, 1.0, "latitude not properly initialized")
        XCTAssertEqual(attraction.longitude, 2.0, "longitude not properly initialized")
        XCTAssertEqual(attraction.radius, 3.0, "radius not properly initialized")
        XCTAssertEqual(attraction.thumbImageName, "thumb_53", "thumbImageName not properly initialized")
        XCTAssertEqual(attraction.backgroundImageName, "background_53", "backgroundImageName not properly initialized")
    }
    
    func testEquatable() {
        let fact = Fact(id:"35", name: "testName", text:"testText")
        let attraction1 = Attraction(id: "53", name: "testName", text: "testText", latitude: 1.0, longitude: 2.0, radius: 3.0, facts: [])
        let attraction2 = Attraction(id: "53", name: "testName", text: "testText", latitude: 1.0, longitude: 2.0, radius: 3.0, facts: [])
        let attraction3 = Attraction(id: "53", name: "testNameDifferent", text: "testTextDifferent", latitude: 1.0, longitude: 2.0, radius: 3.0, facts: [fact])
        let attraction4 = Attraction(id: "53", name: "testName", text: "testText", latitude: 1.02, longitude: 2.0, radius: 3.0, facts: [])
        XCTAssertEqual(attraction1, attraction2, "attraction1 and attraction2 should be equal")
        XCTAssertEqual(attraction2, attraction1, "attraction1 and attraction2 should be equal")
        XCTAssertEqual(attraction1, attraction3, "attraction1 and attraction3 should be equal")
        XCTAssertEqual(attraction3, attraction1, "attraction1 and attraction3 should be equal")
        XCTAssertTrue(attraction1 != attraction4, "attraction1 and attraction3 should be different")
    }

    func testNSCoding() {
        let fact = Fact(id:"35", name: "testName", text:"testText")
        let attraction = Attraction(id: "53", name: "testName", text: "testText", latitude: 1.0, longitude: 2.0, radius: 3.0, facts: [fact])
        let archivedAttraction = NSKeyedArchiver.archivedDataWithRootObject(attraction)
        let retrievedAttraction = NSKeyedUnarchiver.unarchiveObjectWithData(archivedAttraction) as! Attraction
        XCTAssertEqual(attraction, retrievedAttraction, "wrong attraction archived by NSKeyedArchiver")
        XCTAssertEqual(attraction.facts.count, retrievedAttraction.facts.count, "wrong facts length archived by NSKeyedArchiver")
        XCTAssertEqual(attraction.facts[0], retrievedAttraction.facts[0], "wrong fact archived by NSKeyedArchiver")
    }
    
    func testFactIterator() {
        var attraction = Attraction(id: "53", name: "testName", text: "testText", latitude: 1.0, longitude: 2.0, radius: 3.0, facts: [])
        
        var iterator = attraction.factIterator()
        XCTAssertNil(iterator.current(), "No facts should return nil current")
        XCTAssertNil(iterator.prev(), "No facts should return nil prev")
        XCTAssertNil(iterator.next(), "No facts should return nil prev")
        XCTAssertFalse(iterator.isPrev(), "No facts should return no prev")
        XCTAssertFalse(iterator.isNext(), "No facts should return no next")
        
        let fact1 = Fact(id:"35", name: "testName", text:"testText")
        let fact2 = Fact(id:"354", name: "testName2", text:"testText2")
        attraction = Attraction(id: "53", name: "testName", text: "testText", latitude: 1.0, longitude: 2.0, radius: 3.0, facts: [fact1, fact2])
        // create iterator
        iterator = attraction.factIterator()
        XCTAssertFalse(iterator.isPrev(), "First fact. No prev.")
        XCTAssertNil(iterator.prev(), "First fact. Prev should return nil")
        // check current
        XCTAssertEqual(iterator.current()!, fact1, "wrong starting fact")
        // go to next
        XCTAssertTrue(iterator.isNext(), "First fact. Should be a next one.")
        XCTAssertEqual(iterator.next()!, fact2, "next iterated correctly")
        XCTAssertEqual(iterator.current()!, fact2, "current did not change accordingly")
        // next is nil
        XCTAssertFalse(iterator.isNext(), "Last fact. No next.")
        XCTAssertNil(iterator.next(), "Last fact. next() should return nil")
        XCTAssertEqual(iterator.current()!, fact2, "current shouldn't have changed")
        // prev is fact1
        XCTAssertTrue(iterator.isPrev(), "Last fact. Should be a prev one.")
        XCTAssertEqual(iterator.prev()!, fact1, "prev iterated correctly")
        XCTAssertEqual(iterator.current()!, fact1, "current did not change accordingly")
        // prev again
        XCTAssertFalse(iterator.isPrev(), "First fact. No prev.")
        XCTAssertNil(iterator.prev(), "First fact. Prev should return nil")
    }

}
