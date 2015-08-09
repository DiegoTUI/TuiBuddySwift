//
//  debugRegionStatusView.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente Garcia on 14/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class DebugRegionStatusView: UIView {
    
    let kTopMargin: Double = 8.0
    let kBottomMargin: Double = 8.0
    let kLeftMargin: Double = 8.0
    let kRightMargin: Double = 8.0
    let kSpaceBetweenLabels: Double = 8.0
    let kMinimmumLabelHeight: Double = 20.0
    var _labels = Dictionary<String, UILabel>()
    
    func initWithAttractions(attractions: Array<Attraction>) {
        // Add labels with attractions
        let labelSize = labelSizeForRows(count(attractions))
        for (index, attraction) in enumerate(attractions) {
            var label = UILabel(frame: CGRect(origin: CGPoint(x: kLeftMargin, y: kTopMargin + Double(index)*Double(labelSize.height)), size: labelSize))
            label.adjustsFontSizeToFitWidth = true
            label.text = attraction.name
            label.font = UIFont.systemFontOfSize(10)
            self.addSubview(label)
            _labels[attraction.id] = label
        }
    }
    
    func labelSizeForRows(numberOfRows: Int) -> CGSize {
        var width = Double(self.frame.size.width) - kLeftMargin - kRightMargin
        var height = (Double(self.frame.size.height) - kTopMargin - kBottomMargin)/Double(numberOfRows) < (kMinimmumLabelHeight) ? Double(self.frame.size.height)/Double(numberOfRows) - kTopMargin - kBottomMargin : kMinimmumLabelHeight
        return CGSize(width: width, height: height)
    }
    
    func labelForAttractionId(attractionId: String) -> UILabel? {
        return _labels[attractionId]
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
