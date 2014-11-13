//
//  RegionManagerTests.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 13/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation
import CoreLocation
import XCTest

var shouldHaveEnteredRegion = Dictionary<Int32, Bool>()

class mockRegionManagerDelegate: RegionManagerDelegate {
    func didEnterRegion(attractionId: Int32) {
        XCTAssertTrue(shouldHaveEnteredRegion[attractionId]!, "Entered region \(attractionId) and it shouldn't have")
    }
}

class RegionManagerTests: XCTestCase {
    
    var regionManagerInstance: RegionManager? = nil

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialization() {
        regionManagerInstance = RegionManager()
        // check that the region manager creates as many regions as attractions in the db
        var attractions = AttractionManager.sharedInstance.readAttractions()
        for attraction in attractions {
            let region = regionManagerInstance!._regions.filter({$0.identifier == String(attraction.id)})[0]
            XCTAssertEqualWithAccuracy(attraction.latitude, region.center.latitude, 0.01, "attraction and region have different latitude")
            XCTAssertEqualWithAccuracy(attraction.longitude, region.center.longitude, 0.01, "attraction and region have different longitude")
            XCTAssertEqualWithAccuracy(attraction.radius, region.radius, 0.01, "attraction and region have different radius")
        }
    }
    
    func testRegionsForCoordinate() {
        regionManagerInstance = RegionManager()
        var attractions = AttractionManager.sharedInstance.readAttractions()
        for attraction in attractions {
            let regions = regionManagerInstance!.regionsForCoordinate(CLLocationCoordinate2D(latitude: attraction.latitude, longitude: attraction.longitude))
            XCTAssertEqual(countElements(regions), 1, "only the designated region should be returned")
            let region = regions[0]
            XCTAssertEqual(region.identifier, String(attraction.id), "attraction and region have different id")
            XCTAssertEqualWithAccuracy(attraction.latitude, region.center.latitude, 0.01, "attraction and region have different latitude")
            XCTAssertEqualWithAccuracy(attraction.longitude, region.center.longitude, 0.01, "attraction and region have different longitude")
            XCTAssertEqualWithAccuracy(attraction.radius, region.radius, 0.01, "attraction and region have different radius")
        }
    }
    
    func testUpdatingRegions() {
        // test entering and exiting a region and check the _inRegions var and the calls to the delegate methods
        regionManagerInstance = RegionManager()
        // assign a delegate
        regionManagerInstance!.delegate = mockRegionManagerDelegate()
        // we take the first attraction
        var attraction = AttractionManager.sharedInstance.readAttractions()[0]
        // if the first location given by CLLocationManager is inside region 1, didEnterRegion must be called
        shouldHaveEnteredRegion[attraction.id] = true
        regionManagerInstance!.locationManager(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: attraction.latitude, longitude: attraction.longitude)])
        // enter another hundred times. DidEnterRegion should not be called.
        shouldHaveEnteredRegion[attraction.id] = false
        for i in 1...100 {
            regionManagerInstance!.locationManager(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: attraction.latitude, longitude: attraction.longitude)])
        }
        // exit region
        regionManagerInstance!.locationManager(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: 0.0, longitude: 0.0)])
        // enter again. didEnterRegion should be called
        shouldHaveEnteredRegion[attraction.id] = true
        regionManagerInstance!.locationManager(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: attraction.latitude, longitude: attraction.longitude)])
        // exit a hundred times. didEnterRegion should not be called
        shouldHaveEnteredRegion[attraction.id] = true
        for i in 1...100 {
            regionManagerInstance!.locationManager(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: 0.0, longitude: 0.0)])
        }
        // enter again. didEnterRegion should be called
        shouldHaveEnteredRegion[attraction.id] = true
        regionManagerInstance!.locationManager(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: attraction.latitude, longitude: attraction.longitude)])
    }
}
