//
//  AttractionFactViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 24/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class AttractionFactViewController: UIViewController {
    var attraction: Attraction? = nil
    var currentFact: Fact? = nil
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shakeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        // set title in navigation bar
        navigationItem.title = "Fact #\(currentFact?.id)"
        // set description
        descriptionLabel.text = currentFact?.text
        // show/hide shakeLabel
        //shakeLabel.hidden = (nextFact == nil)
    }
    
    // MARK: - Shaking -
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            // push a new view controller into the Navigation View Controller if there is a nextFact
            /*if let next = nextFact {
                var destinationViewController = AttractionFactViewController()
                
            }*/
        }
    }

    // MARK: - Actions -
    
    @IBAction func closeButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
