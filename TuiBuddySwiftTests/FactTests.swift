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
    
    func testInit() {
        let fact = Fact(id:"53", name: "testName", text:"testText")
        XCTAssertEqual(fact.id, "53", "id was not initialized properly")
        XCTAssertEqual(fact.name, "testName", "name was not initialized properly")
        XCTAssertEqual(fact.text, "testText", "text was not initialized properly")
        XCTAssertEqual(fact.imageName, kInvalidString, "text was not initialized properly")
    }

    func testEquatable() {
        let fact1 = Fact(id:"53", name: "testName", text:"testText")
        let fact2 = Fact(id:"53", name: "testName", text:"testText")
        let fact3 = Fact(id:"53", name: "testName", text:"testDifferentText")
        XCTAssertEqual(fact1, fact2, "fact1 and fact2 should be equal")
        XCTAssertEqual(fact2, fact1, "fact1 and fact2 should be equal")
        XCTAssertTrue(fact1 != fact3, "fact1 and fact3 should be different")
    }
    
    func testNSCoding() {
        let fact = Fact(id:"53", name: "testName", text:"testDifferentText")
        let archivedFact = NSKeyedArchiver.archivedDataWithRootObject(fact)
        let retrievedFact = NSKeyedUnarchiver.unarchiveObjectWithData(archivedFact) as! Fact
        XCTAssertEqual(fact, retrievedFact, "wrong fact archived by NSKeyedArchiver")
    }

}
