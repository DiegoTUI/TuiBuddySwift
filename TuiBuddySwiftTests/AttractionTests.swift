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
        config.fakeCMS = "attractions_test"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        config.fakeCMS = "attractions"
        super.tearDown()
    }
    
    func testEquatable() {
        let attraction1 = Attraction(id:53, name:"testName", latitude:5.53, longitude: 6.54, radius: 4.003, url:"testUrl", facts:[Fact()])
        let attraction2 = Attraction(id:53, name:"testName", latitude:5.53, longitude: 6.54, radius: 4.003, url:"testUrl", facts:[Fact()])
        let attraction3 = Attraction(id:53, name:"testNameDifferent", latitude:5.53, longitude: 6.54, radius: 4.003, url:"testUrl", facts:[Fact()])
        let attraction4 = Attraction(id:53, name:"testName", latitude:5.53, longitude: 6.54, radius: 4.003, url:"testUrl", facts:[Fact(), Fact()])
        XCTAssertEqual(attraction1, attraction2, "attraction1 and attraction2 should be equal")
        XCTAssertEqual(attraction2, attraction1, "attraction1 and attraction2 should be equal")
        XCTAssertTrue(attraction1 != attraction3, "attraction1 and attraction3 should be different")
        XCTAssertTrue(attraction1 != attraction4, "attraction1 and attraction3 should be different")
    }

    func testNSCoding() {
        let attraction = Attraction(id:53, name:"testName", latitude:5.53, longitude: 6.54, radius: 4.003, url:"testUrl", facts:[Fact()])
        let archivedAttraction = NSKeyedArchiver.archivedDataWithRootObject(attraction)
        let retrievedAttraction = NSKeyedUnarchiver.unarchiveObjectWithData(archivedAttraction) as Attraction
        XCTAssertEqual(attraction, retrievedAttraction, "wrong attraction archived by NSKeyedArchiver")
    }
    
    func testRefreshFacts() {
        var attraction = Attraction()
        attraction.refreshFacts()
        XCTAssertEqual(countElements(attraction.facts), 0, "refreshFacts of unexisting id should return 0 facts")
        attraction.id = 1
        attraction.refreshFacts()
        XCTAssertEqual(countElements(attraction.facts), 2, "refreshFacts of attraction 1 should return 2 facts")
        for (index, fact) in enumerate(attraction.facts) {
            let id = index + 1
            XCTAssertEqual(fact.id, Int32(id), "wrong id in fact \(id)")
            XCTAssertEqual(fact.attractionId, attraction.id, "wrong attractionId in fact \(id)")
            XCTAssertEqual(fact.text, "fact\(id)", "wrong text in fact \(id)")
            XCTAssertEqual(fact.type, "type\(id)", "wrong type in fact \(id)")
            XCTAssertEqual(fact.resource, "resource\(id)", "wrong resource in fact \(id)")
        }
    }

}
