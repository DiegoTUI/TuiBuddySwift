//
//  Fact.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 24/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation

class Fact: NSObject, NSCoding, Equatable {
    var id: String = kInvalidString
    var name: String = kInvalidString
    var text: String = kInvalidString
    var imageName: String = kInvalidString
    
    // MARK: - Initialization
    
    override init () {
        super.init()
    }
    
    init(id: String,
        name: String,
        text: String) {
            super.init()
            self.id = id
            self.name = name
            self.text = text
    }
    
    //MARK: - NSCoding protocol
    
    convenience required init(coder decoder: NSCoder) {
        self.init()
        id = decoder.decodeObjectForKey("id") as String
        name = decoder.decodeObjectForKey("name") as String
        text = decoder.decodeObjectForKey("text") as String
        imageName = decoder.decodeObjectForKey("imageName") as String
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(id, forKey:"id")
        encoder.encodeObject(name, forKey:"name")
        encoder.encodeObject(text, forKey:"text")
        encoder.encodeObject(imageName, forKey:"imageName")
    }
}

//MARK: - Equatable protocol

func == (left: Fact, right: Fact) -> Bool {
    return left.id == right.id &&
        left.name == right.name &&
        left.text == right.text &&
        left.imageName == right.imageName
}
