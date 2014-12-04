//
//  IteratorTests.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 04/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit
import XCTest

class IteratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyIterator() {
        let stringArray: [String] = []
        let iterator = Iterator<String>(items: stringArray)
        XCTAssertNil(iterator.current(), "empty iterator has no current item")
        XCTAssertNil(iterator.next(), "empty iterator has no next item")
        XCTAssertNil(iterator.prev(), "empty iterator has no prev item")
        XCTAssertFalse(iterator.isNext(), "isNext is false in an empty iterator")
        XCTAssertFalse(iterator.isPrev(), "isPrev is false in an empty iterator")
    }

    func testStringIterator() {
        let stringArray = ["1", "2", "3"]
        let iterator = Iterator<String>(items: stringArray)
        // first element
        XCTAssertNotNil(iterator.current(), "current item should exist in this iterator")
        XCTAssertEqual(iterator.current()!, "1", "wrong first element of this iterator")
        XCTAssertTrue(iterator.isNext(), "isNext is true in the first item of this iterator")
        XCTAssertFalse(iterator.isPrev(), "isPrev is false in the first item of this iterator")
        XCTAssertNil(iterator.prev(), "first element: no prev element")
        // next
        XCTAssertNotNil(iterator.next(), "first element has next item in this iterator")
        XCTAssertEqual(iterator.current()!, "2", "wrong second element of the iterator")
        XCTAssertTrue(iterator.isNext(), "isNext is true in the second item of this iterator")
        XCTAssertTrue(iterator.isPrev(), "isPrev is true in the second item of this iterator")
        // next
        XCTAssertNotNil(iterator.next(), "second element has next item in this iterator")
        XCTAssertEqual(iterator.current()!, "3", "wrong third element of the iterator")
        XCTAssertFalse(iterator.isNext(), "isNext is false in the third item of this iterator")
        XCTAssertTrue(iterator.isPrev(), "isPrev is true in the third item of this iterator")
        XCTAssertNil(iterator.next(), "Third item has no next in this iterator")
        // prev
        XCTAssertNotNil(iterator.prev(), "third element has next item in this iterator")
        XCTAssertEqual(iterator.current()!, "2", "wrong second element of the iterator")
        XCTAssertTrue(iterator.isNext(), "isNext is true in the second item of this iterator")
        XCTAssertTrue(iterator.isPrev(), "isPrev is true in the second item of this iterator")
        // prev
        XCTAssertNotNil(iterator.prev(), "first element has next item in this iterator")
        XCTAssertEqual(iterator.current()!, "1", "wrong first element of this iterator")
        XCTAssertTrue(iterator.isNext(), "isNext is true in the first item of this iterator")
        XCTAssertFalse(iterator.isPrev(), "isPrev is false in the first item of this iterator")
        XCTAssertNil(iterator.prev(), "first element: no prev element")
    }

}
