//
//  RegionManager.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 11/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol RegionManagerDelegate {
    func didEnterRegion(attractionId: Int32)
}

class RegionManager: NSObject, CLLocationManagerDelegate {
    
    var _regions = Array<CLCircularRegion>()
    var _locationManager = CLLocationManager()
    var _inRegions = Array<String>()
    
    var delegate:RegionManagerDelegate? = nil
    
    // MARK: - Shared instance
    
    class var sharedInstance: RegionManager {
        struct Static {
            static var instance: RegionManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = RegionManager()
        }
        
        return Static.instance!
    }
    
    // MARK: - Construction and destruction
    
    override init() {
        super.init()
        // update regions
        updateRegions()
        // init RegionManager
        // request authorization if os version higher than 8.0.0
        if UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) != .OrderedAscending {
            _locationManager.requestAlwaysAuthorization()
        }
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
    }
    
    // MARK: - Update regions
    
    func updateRegions() {
        for attraction:Attraction in AttractionManager.sharedInstance.readAttractions() {
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: attraction.latitude, longitude: attraction.longitude),
                radius: attraction.radius,
                identifier: String(attraction.id))
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
    
    func regionsForCoordinate(coordinate: CLLocationCoordinate2D) -> [CLCircularRegion] {
        var regions = Array<CLCircularRegion>()
        for region in _regions {
            if region.containsCoordinate(coordinate) {
                regions.append(region)
            }
        }
        return regions
    }
    
    // MARK: - CLLocationDelegate
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]) {
        println("did update locations")
        let location = (locations.last as CLLocation)
        let regions = regionsForCoordinate(location.coordinate)
        var newInRegions = Array<String>()
        for region in regions {
            newInRegions.append(region.identifier)
            // we only enter a region when we were out of it before
            if !contains(_inRegions, region.identifier) {
                _inRegions.append(region.identifier)
                delegate?.didEnterRegion(Int32(region.identifier.toInt()!))
            }
        }
        _inRegions = newInRegions
    }
}