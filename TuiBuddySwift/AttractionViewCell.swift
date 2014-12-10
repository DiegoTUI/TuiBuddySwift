//
//  AttractionViewCell.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 02/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

protocol AttractionViewCellDelegate {
    // called when an attraction should be edited
    func editAttraction(attraction: Attraction)
}

class AttractionViewCell: BaseCollectionViewCell {
    // Views
    var _titleLabel: UILabel? = nil
    var _textLabel: UILabel? = nil
    var _mainImageView: UIImageView? = nil
    // Layout constants
    let kDefaultOffset = 8.0
    let kImageUpperOffset = 5.0
    let kBetweenLabelsOffset = 0.0
    let kImageViewHeight = 80.0
    let kImageViewWidth = 80.0
    let kLabelHeight = 18.0
    // delegate
    var delegate: AttractionViewCellDelegate? = nil
    // attraction
    var attraction: Attraction? = nil
    
    // MARK: Setup
    
    override func setup() {
        removeViews()
        // main image
        _mainImageView = UIImageView(frame: CGRect(x: kDefaultOffset, y: kImageUpperOffset, width: kImageViewWidth, height: kImageViewHeight))
        // Title and text labels
        let kLabelX = 2.0 * kDefaultOffset + kImageViewWidth
        let kLabelWidth = Double(self.frame.width) - kLabelX - kDefaultOffset
        let kTextLabelY = kDefaultOffset + kBetweenLabelsOffset + kLabelHeight
        _titleLabel = UILabel(frame: CGRect(x: kLabelX, y: kDefaultOffset, width: kLabelWidth, height: kLabelHeight))
        _titleLabel!.font = UIFont(name: kBoldFont, size: CGFloat(kH2FontSize))!
        _titleLabel!.textColor = kDarkBlueColor
        _textLabel = UILabel(frame: CGRect(x: kLabelX, y: kTextLabelY, width: kLabelWidth, height: kLabelHeight))
        _textLabel!.font = UIFont(name: kRegularFont, size: CGFloat(kH3FontSize))!
        _textLabel!.textColor = kDarkBlueColor
        _textLabel!.lineBreakMode = .ByWordWrapping
        _textLabel!.numberOfLines = 0
        // add subviews
        addSubview(_mainImageView!)
        addSubview(_titleLabel!)
        addSubview(_textLabel!)
        // Refresh contants (if there if a valid attraction)
        if (attraction != nil) {
            refreshContents()
        }
    }
    
    func refreshContents() {
        // title label
        _titleLabel!.text = attraction!.name
        // text label
        _textLabel!.text = attraction!.text
        _textLabel!.sizeToFit()
        // image
        var mainImage = UIImage(named: attraction!.thumbImageName)
        _mainImageView!.image = UIImage(named: attraction!.thumbImageName)
        // make it circular
        var imageLayer = _mainImageView!.layer
        imageLayer.cornerRadius = _mainImageView == nil ? 40.0 : _mainImageView!.frame.size.width/2.0
        imageLayer.masksToBounds = true
        _mainImageView!.clipsToBounds = true
    }

    func removeViews() {
        _titleLabel?.removeFromSuperview()
        _textLabel?.removeFromSuperview()
        _mainImageView?.removeFromSuperview()
    }
    
    // MARK: Menu actions
    func editMenuOptionClicked(sender: AnyObject?) {
        if let currentAttraction = attraction {
            delegate?.editAttraction(currentAttraction)
        }
    }
    
    // MARK: Contains attraction
    func containsAttraction(attraction: Attraction) -> Bool {
        if attraction.id == self.attraction?.id {
            return true
        }
        return false
    }
    
}
