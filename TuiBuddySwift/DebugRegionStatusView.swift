//
//  debugRegionStatusView.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente Garcia on 14/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class DebugRegionStatusView: UIView {
    
    var _labels = Dictionary<Int32, UILabel>()
    
    func initWithAttractions(attractions: Array<Attraction>) {
        // Add labels with attractions
    }
    
    func labelForAttraction(attraction: Attraction) -> UILabel? {
        return _labels[attraction.id]
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
