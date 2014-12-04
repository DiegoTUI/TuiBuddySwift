//
//  CmsManagerTests.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 04/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit
import XCTest

class CmsManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        config.fakeCMS = "attractions_test"
        CmsManager.sharedInstance.reloadCmsContents()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        config.fakeCMS = "attractions"
        super.tearDown()
    }

    func testIterateCms() {
        let iterator = CmsManager.sharedInstance.cmsItemIterator()
        XCTAssertNotNil(iterator.current(), "current should not be nil")
        // attraction 1
        let cmsAttraction1: NSDictionary = iterator.current()!
        XCTAssertEqual(cmsAttraction1["attractionId"] as String, "1", "wrong id retrieved in cmsAttraction1")
        XCTAssertEqual(cmsAttraction1["attractionName"] as String, "attractionName_1", "wrong attraction name retrieved in cmsAttraction1")
        XCTAssertEqual(cmsAttraction1["attractionText"] as String, "attractionText_1", "wrong attraction text retrieved in cmsAttraction1")
        let facts1: NSArray = cmsAttraction1["facts"] as NSArray
        XCTAssertEqual(facts1.count, 3, "wrong number of facts for cmsAttraction1")
        XCTAssertEqual((facts1[0] as NSDictionary)["factId"] as String, "1", "wrong factId for fact1 cmsAttraction1")
        XCTAssertEqual((facts1[0] as NSDictionary)["factTitle"] as String, "factTitle_1_1", "wrong factTitle for fact1 cmsAttraction1")
        XCTAssertEqual((facts1[0] as NSDictionary)["factText"] as String, "factText_1_1", "wrong factText for fact1 cmsAttraction1")
        XCTAssertEqual((facts1[1] as NSDictionary)["factId"] as String, "2", "wrong factId for fact2 cmsAttraction1")
        XCTAssertEqual((facts1[1] as NSDictionary)["factTitle"] as String, "factTitle_1_2", "wrong factTitle for fact2 cmsAttraction1")
        XCTAssertEqual((facts1[1] as NSDictionary)["factText"] as String, "factText_1_2", "wrong factText for fact2 cmsAttraction1")
        XCTAssertEqual((facts1[2] as NSDictionary)["factId"] as String, "3", "wrong factId for fact3 cmsAttraction1")
        XCTAssertEqual((facts1[2] as NSDictionary)["factTitle"] as String, "factTitle_1_3", "wrong factTitle for fact3 cmsAttraction1")
        XCTAssertEqual((facts1[2] as NSDictionary)["factText"] as String, "factText_1_3", "wrong factText for fact3 cmsAttraction1")
        // attraction 2
        let cmsAttraction2: NSDictionary = iterator.next()!
        XCTAssertEqual(cmsAttraction2["attractionId"] as String, "2", "wrong id retrieved in cmsAttraction2")
        XCTAssertEqual(cmsAttraction2["attractionName"] as String, "attractionName_2", "wrong attraction name retrieved in cmsAttraction2")
        XCTAssertEqual(cmsAttraction2["attractionText"] as String, "attractionText_2", "wrong attraction text retrieved in cmsAttraction2")
        let facts2: NSArray = cmsAttraction2["facts"] as NSArray
        XCTAssertEqual(facts2.count, 2, "wrong number of facts for cmsAttraction2")
        XCTAssertEqual((facts2[0] as NSDictionary)["factId"] as String, "1", "wrong factId for fact1 cmsAttraction2")
        XCTAssertEqual((facts2[0] as NSDictionary)["factTitle"] as String, "factTitle_2_1", "wrong factTitle for fact1 cmsAttraction2")
        XCTAssertEqual((facts2[0] as NSDictionary)["factText"] as String, "factText_2_1", "wrong factText for fact1 cmsAttraction2")
        XCTAssertEqual((facts2[1] as NSDictionary)["factId"] as String, "2", "wrong factId for fact2 cmsAttraction2")
        XCTAssertEqual((facts2[1] as NSDictionary)["factTitle"] as String, "factTitle_2_2", "wrong factTitle for fact2 cmsAttraction2")
        XCTAssertEqual((facts2[1] as NSDictionary)["factText"] as String, "factText_2_2", "wrong factText for fact2 cmsAttraction2")
        // no more attractions in the iterator
        XCTAssertFalse(iterator.isNext(), "only 2 attractions in the cms")
    }

}
