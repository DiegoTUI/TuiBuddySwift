//
//  Attraction.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 10/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation

class Attraction: NSObject, NSCoding, Equatable {
    var id: String = kInvalidString
    var name: String = kInvalidString
    var text: String = kInvalidString
    var latitude: Double = kInvalidDouble
    var longitude: Double = kInvalidDouble
    var radius: Double = kInvalidDouble
    var facts: [Fact] = []
    var thumbImageName: String = kInvalidString
    var backgroundImageName: String = kInvalidString
    
    // MARK: - Initialization
    
    override init () {
        super.init()
    }
    
    init(id: String,
        name: String,
        text: String,
        latitude: Double,
        longitude: Double,
        radius: Double,
        facts: [Fact]) {
            super.init()
            self.id = id
            self.name = name
            self.text = text
            self.latitude = latitude
            self.longitude = longitude
            self.radius = radius
            self.facts = facts
            _buildImageNames()
    }
    
    // MARK: - Facts
    
    func factIterator() -> Iterator<Fact> {
        return Iterator<Fact>(items: self.facts)
    }
    
    //MARK: - NSCoding protocol
    
    convenience required init(coder decoder: NSCoder) {
        self.init()
        id = decoder.decodeObjectForKey("id") as! String
        name = decoder.decodeObjectForKey("name") as! String
        text = decoder.decodeObjectForKey("text") as! String
        latitude = decoder.decodeDoubleForKey("latitude")
        longitude = decoder.decodeDoubleForKey("longitude")
        radius = decoder.decodeDoubleForKey("radius")
        facts = decoder.decodeObjectForKey("facts") as! [Fact]
        _buildImageNames()
    }
    
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(id, forKey:"id")
        encoder.encodeObject(name, forKey:"name")
        encoder.encodeObject(text, forKey:"text")
        encoder.encodeDouble(latitude, forKey:"latitude")
        encoder.encodeDouble(longitude, forKey:"longitude")
        encoder.encodeDouble(radius, forKey:"radius")
        encoder.encodeObject(facts, forKey:"facts")
    }
    
    // MARK: build image names from attributes
    func _buildImageNames() {
        self.thumbImageName = "thumb_\(self.id)"
        self.backgroundImageName = "background_\(self.id)"
    }
}

//MARK: - Equatable protocol
    
func == (left: Attraction, right: Attraction) -> Bool {
    return left.id == right.id &&
        left.latitude == right.latitude &&
        left.longitude == right.longitude &&
        left.radius == right.radius
}
