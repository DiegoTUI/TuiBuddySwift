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

    func testNSCoding() {
        let attraction = Attraction(id:53, name:"testName", latitude:5.53, longitude: 6.54, radius: 4.003, url:"testUrl")
        let archivedAttraction = NSKeyedArchiver.archivedDataWithRootObject(attraction)
        let retrievedAttraction = NSKeyedUnarchiver.unarchiveObjectWithData(archivedAttraction) as Attraction
        XCTAssertEqual(attraction.id, retrievedAttraction.id, "wrong id archived in notification")
        XCTAssertEqual(attraction.name, retrievedAttraction.name, "wrong name archived in notification")
        XCTAssertEqual(attraction.latitude, retrievedAttraction.latitude, "wrong latitude archived in notification")
        XCTAssertEqual(attraction.longitude, retrievedAttraction.longitude, "wrong longitude archived in notification")
        XCTAssertEqual(attraction.radius, retrievedAttraction.radius, "wrong radius archived in notification")
        XCTAssertEqual(attraction.url, retrievedAttraction.url, "wrong url archived in notification")
    }

}
