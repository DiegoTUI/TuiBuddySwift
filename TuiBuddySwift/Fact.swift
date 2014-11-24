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
    var text: String = ""
    var type: String = ""
    var resource: String = ""
    
    // MARK: - Initialization
    
    override init () {
        super.init()
    }
    
    init(id: Int32 = -1,
        text: String,
        type: String,
        resource: String) {
            super.init()
            self.id = id
            self.text = text
            self.type = type
            self.resource = resource
    }
    
    //MARK: - NSCoding protocol
    
    convenience required init(coder decoder: NSCoder) {
        self.init()
        id = decoder.decodeInt32ForKey("id")
        text = decoder.decodeObjectForKey("text") as String
        type = decoder.decodeObjectForKey("type") as String
        resource = decoder.decodeObjectForKey("resource") as String
    }
    
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeInt32(id, forKey:"id")
        encoder.encodeObject(text, forKey:"text")
        encoder.encodeObject(type, forKey:"type")
        encoder.encodeObject(resource, forKey:"resource")
    }
}

//MARK: - Equatable protocol

func == (left: Fact, right: Fact) -> Bool {
    return left.id == right.id &&
        left.text == right.text &&
        left.type == right.type &&
        left.resource == right.resource 
}
