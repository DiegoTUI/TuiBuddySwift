//
//  Attraction.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 10/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation

class Attraction: NSObject {
    var id: Int32 = -1
    var name: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var radius: Double = 0.0
    var url: String = ""
    
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
}