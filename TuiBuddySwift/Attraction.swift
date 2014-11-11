//
//  Attraction.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 10/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation

struct Attraction {
    var rowid: Int32 = -1
    var name: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var radius: Double = 0.0
    var link: String = ""
    
    init () {}
    
    init(rowid: Int32 = -1,
        name: String,
        latitude: Double,
        longitude: Double,
        radius: Double,
        link: String) {
            self.rowid = rowid
            self.name = name
            self.latitude = latitude
            self.longitude = longitude
            self.radius = radius
            self.link = link
    }
}