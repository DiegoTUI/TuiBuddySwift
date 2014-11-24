//
//  Fact.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 24/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation

class Fact: NSObject, NSCoding, Equatable {
    var id: Int32 = -1
    var attractionId: Int32 = -1
    var text: String = ""
    var type: String = ""
    var resource: String = ""
    
    // MARK: - Initialization
    
    override init () {
        super.init()
    }
    
    init(id: Int32 = -1,
        attractionId: Int32 = -1,
        text: String,
        type: String,
        resource: String) {
            super.init()
            self.id = id
            self.attractionId = attractionId
            self.text = text
            self.type = type
            self.resource = resource
    }
    
    init(nsDictionary: NSDictionary, attractionId: Int32) {
        super.init()
        self.id = Int32(nsDictionary["id"] as Int)
        self.attractionId = attractionId
        self.text = nsDictionary["text"] as String
        self.type = (nsDictionary["media"] as NSDictionary)["type"] as String
        self.resource = (nsDictionary["media"] as NSDictionary)["resource"] as String
    }
    
    //MARK: - NSCoding protocol
    
    convenience required init(coder decoder: NSCoder) {
        self.init()
        id = decoder.decodeInt32ForKey("id")
        attractionId = decoder.decodeInt32ForKey("attractionId")
        text = decoder.decodeObjectForKey("text") as String
        type = decoder.decodeObjectForKey("type") as String
        resource = decoder.decodeObjectForKey("resource") as String
    }
    
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeInt32(id, forKey:"id")
        encoder.encodeInt32(attractionId, forKey:"attractionId")
        encoder.encodeObject(text, forKey:"text")
        encoder.encodeObject(type, forKey:"type")
        encoder.encodeObject(resource, forKey:"resource")
    }
}

//MARK: - Equatable protocol

func == (left: Fact, right: Fact) -> Bool {
    return left.id == right.id &&
        left.attractionId == right.attractionId &&
        left.text == right.text &&
        left.type == right.type &&
        left.resource == right.resource
}