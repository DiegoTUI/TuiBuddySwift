//
//  LocationManager.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 11/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var _regions = Array<CLCircularRegion>()
    var _locationManager = CLLocationManager()
    
    // MARK: - Shared instance
    
    class var sharedInstance: LocationManager {
        struct Static {
            static var instance: LocationManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = LocationManager()
        }
        
        return Static.instance!
    }
    
    // MARK: - Construction and destruction
    
    override init() {
        super.init()
        // update regions
        updateRegions()
        // init locationManager
        // request authorization if os version higher than 8.0.0
        if UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) != .OrderedAscending {
            _locationManager.requestAlwaysAuthorization()
        }
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
    }
    
    // MARK: - Update regions
    
    func updateRegions() {
        for attraction:Attraction in SqliteManager.sharedInstance.readAttractions() {
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: attraction.latitude, longitude: attraction.longitude),
                radius: attraction.radius,
                identifier: String(attraction.rowid))
            _regions.append(region)
        }
    }
    
    // MARK: - Monitor regions
    
    func startMonitoringRegions() {
        _locationManager.startUpdatingLocation()
    }
    
    func stopMonitoringRegions() {
        _locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationDelegate
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]) {
        println("did update locations")
    }
}