//
//  FactTests.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 24/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation
import XCTest

class FactTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEquatable() {
        let fact1 = Fact(id:53, attractionId: 32, text:"testText", type:"testType", resource: "testResource")
        let fact2 = Fact(id:53, attractionId: 32, text:"testText", type:"testType", resource: "testResource")
        let fact3 = Fact(id:53, attractionId: 32, text:"testTextDifferent", type:"testType", resource: "testResource")
        XCTAssertEqual(fact1, fact2, "fact1 and fact2 should be equal")
        XCTAssertEqual(fact2, fact1, "fact1 and fact2 should be equal")
        XCTAssertTrue(fact1 != fact3, "fact1 and fact3 should be different")
    }
    
    func testNSCoding() {
        let fact = Fact(id:53, text:"testText", type:"testType", resource: "testResource")
        let archivedFact = NSKeyedArchiver.archivedDataWithRootObject(fact)
        let retrievedFact = NSKeyedUnarchiver.unarchiveObjectWithData(archivedFact) as Fact
        XCTAssertEqual(fact, retrievedFact, "wrong fact archived by NSKeyedArchiver")
    }

}
