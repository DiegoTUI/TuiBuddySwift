//
//  AttractionFactViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 24/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class AttractionFactViewController: UIViewController {
    
    private struct StaticStruct { static var _factIterator: FactIterator? = nil }
    
    class var factIterator: FactIterator? {
        get {return StaticStruct._factIterator}
        set {StaticStruct._factIterator = newValue}
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shakeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        var currentFact = AttractionFactViewController.factIterator?.current()
        let title = currentFact?.id == nil ? "" : "\(currentFact!.id)"
        let description = currentFact?.text == nil ? "" : "\(currentFact!.text)"
        // set title in navigation bar
        navigationItem.title = "Fact #\(title)"
        // set description
        descriptionLabel.text = description
        // show/hide shakeLabel
        shakeLabel.hidden = AttractionFactViewController.factIterator == nil || !AttractionFactViewController.factIterator!.isNext()
    }
    
    // MARK: - Shaking -
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            // push a new view controller into the Navigation View Controller if there is a nextFact
            if let nextFact = AttractionFactViewController.factIterator?.next() {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                var destinationViewController = storyBoard.instantiateViewControllerWithIdentifier("attractionFactViewController") as AttractionFactViewController
                self.navigationController?.pushViewController(destinationViewController, animated: true)
            }
        }
    }
    
    // MARK: - Back button -
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if (parent == nil) {
            println("back button clicked")
            AttractionFactViewController.factIterator?.prev()
        }
    }

    // MARK: - Actions -
    
    @IBAction func closeButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
