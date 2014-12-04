//
//  CmsManager.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 03/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import Foundation

class CmsManager {
    // the contents of the CMS
    var _cmsContents: NSArray? = nil
    
    // MARK: - Shared instance
    
    class var sharedInstance: CmsManager {
        struct Static {
            static var instance: CmsManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = CmsManager()
        }
        
        return Static.instance!
    }
    
    // MARK: - Initialization
    
    init() {
        reloadCmsContents()
    }
    
    // MARK: - Iteration
    
    func cmsItemIterator() -> Iterator<NSDictionary> {
        return Iterator<NSDictionary>(items: _cmsContents as [NSDictionary])
    }
    
    // MARK: - Reload cms (only used for test purposes)
    
    func reloadCmsContents() {
        if let path = NSBundle.mainBundle().pathForResource(config.fakeCMS, ofType: "plist") {
            _cmsContents = NSArray(contentsOfFile: path)
        }
    }
}