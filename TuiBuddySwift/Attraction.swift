//
//  Attraction.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 10/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation

class Attraction: NSObject, NSCoding, Equatable {
    var id: Int32 = -1
    var name: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var radius: Double = 0.0
    var url: String = ""
    var facts = Array<Fact>()
    
    // MARK: - Initialization
    
    override init () {
        super.init()
    }
    
    init(id: Int32 = -1,
        name: String,
        latitude: Double,
        longitude: Double,
        radius: Double,
        url: String,
        facts: [Fact] = []) {
            super.init()
            self.id = id
            self.name = name
            self.latitude = latitude
            self.longitude = longitude
            self.radius = radius
            self.url = url
            self.facts = facts
    }
    
    // MARK: - Facts
    // refresh facts from the fake cms
    func refreshFacts() {
        var newFacts = Array<Fact>()
        // read facts from fake CMS
        var cmsContents: NSArray? = nil
        if let path = NSBundle.mainBundle().pathForResource(config.fakeCMS, ofType: "plist") {
            cmsContents = NSArray(contentsOfFile: path)
        }
        // add facts if any
        let indexSet = cmsContents?.indexesOfObjectsPassingTest() { (item, index, weirdPointer) in
            let attractionId = (item as NSDictionary)["id"] as Int
            return Int32(attractionId) == self.id
        }
        if indexSet != nil && indexSet?.count > 0 {
            let facts: NSArray! = (cmsContents!.objectsAtIndexes(indexSet!)[0] as NSDictionary)["facts"] as NSArray
            for fact in facts {
                newFacts.append(Fact(nsDictionary: fact as NSDictionary, attractionId: self.id))
            }
        }
        self.facts = newFacts
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
        facts = decoder.decodeObjectForKey("facts") as [Fact]
    }
    
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeInt32(id, forKey:"id")
        encoder.encodeObject(name, forKey:"name")
        encoder.encodeDouble(latitude, forKey:"latitude")
        encoder.encodeDouble(longitude, forKey:"longitude")
        encoder.encodeDouble(radius, forKey:"radius")
        encoder.encodeObject(url, forKey:"url")
        encoder.encodeObject(facts, forKey:"facts")
    }
}

//MARK: - Equatable protocol
    
func == (left: Attraction, right: Attraction) -> Bool {
    return left.id == right.id &&
        left.name == right.name &&
        left.latitude == right.latitude &&
        left.longitude == right.longitude &&
        left.radius == right.radius &&
        left.facts == right.facts
}
