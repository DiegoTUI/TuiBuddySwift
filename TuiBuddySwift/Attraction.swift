//
//  Attraction.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 10/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation

class Attraction: NSObject, NSCoding {
    var id: Int32 = -1
    var name: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var radius: Double = 0.0
    var url: String = ""
    
    // MARK: - Initialization
    
    override init () {
        super.init()
    }
    
    init(id: Int32 = -1,
        name: String,
        latitude: Double,
        longitude: Double,
        radius: Double,
        url: String) {
            super.init()
            self.id = id
            self.name = name
            self.latitude = latitude
            self.longitude = longitude
            self.radius = radius
            self.url = url
    }
    
    //MARK: - NSCoding protocol
    
    convenience required init(coder decoder: NSCoder) {
        self.init()
        id = decoder.decodeInt32ForKey("id")
        name = decoder.decodeObjectForKey("name") as String
        latitude = decoder.decodeDoubleForKey("latitude")
        longitude = decoder.decodeDoubleForKey("longitude")
        radius = decoder.decodeDoubleForKey("radius")
        url = decoder.decodeObjectForKey("url") as String
    }
    
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeInt32(id, forKey:"id")
        encoder.encodeObject(name, forKey:"name")
        encoder.encodeDouble(latitude, forKey:"latitude")
        encoder.encodeDouble(longitude, forKey:"longitude")
        encoder.encodeDouble(radius, forKey:"radius")
        encoder.encodeObject(url, forKey:"url")
    }
}