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
    // called when an attraction should be deleted
    func deleteAttraction(attraction: Attraction)
}

class AttractionViewCell: UICollectionViewCell {
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    // delegate
    var delegate: AttractionViewCellDelegate? = nil
    // attraction
    var attraction: Attraction? = nil
    
    // MARK: Setup
    func setup() {
        titleLabel.text = attraction?.name
    }
    
    // MARK: Menu actions
    func editMenuOptionClicked(sender: AnyObject?) {
        if let currentAttraction = attraction {
            delegate?.editAttraction(currentAttraction)
        }
    }
    
    func deleteMenuOptionClicked(sender: AnyObject?) {
        if let currentAttraction = attraction {
            delegate?.deleteAttraction(currentAttraction)
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
