//
//  DebugViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 14/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit
import CoreLocation

protocol DebugViewControllerDelegate {
    func closeButtonClicked()
}

class DebugViewController: UIViewController, RegionManagerDelegate {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var actionsTextView: UITextView!
    @IBOutlet weak var regionStatusView: DebugRegionStatusView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // empty actionsTextView
        actionsTextView.text = ""
        // init regionStatusView
        regionStatusView.initWithAttractions(AttractionManager.sharedInstance.readAttractions())
        // capture Region Manager Delegate
        RegionManager.sharedInstance.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - RegionManagerDelegate
    
    func didEnterRegion(attractionId: Int32) {
        regionStatusView.labelForAttractionId(attractionId)?.textColor = UIColor.redColor()
        log("entered region: \(attractionId)")
    }
    
    func didExitRegion(attractionId: Int32) {
        regionStatusView.labelForAttractionId(attractionId)?.textColor = UIColor.blueColor()
        log("exited region: \(attractionId)")
    }
    
    func didUpdateLocation(location: CLLocation) {
        // update labels
        latitudeLabel.text = "\(location.coordinate.latitude)"
        longitudeLabel.text = "\(location.coordinate.longitude)"
        // add to actionsTextView
        log("updated location")
    }
    
    // MARK: - Logging
    
    func log(message: String) {
        actionsTextView.text = "\(actionsTextView.text)updated location\n"
    }
}
