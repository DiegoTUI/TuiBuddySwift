//
//  FactViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 05/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class FactViewController: UIViewController {
    // outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var factTextView: UIView!
    @IBOutlet weak var swipeForMoreLabel: UILabel!
    @IBOutlet weak var factImageView: UIImageView!
    // the fact
    var fact: Fact? = nil
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (fact != nil) {
            setupView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Setup view
    
    func setupView () {
        titleLabel.text = fact!.name
    }
    
    // MARK: Actions
    
    @IBAction func closeButtonClicked(sender: AnyObject) {
    }
}
