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

}
