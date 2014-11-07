//
//  AddEditAttractionViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 07/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class AddEditAttractionViewController: UIViewController {
    
    var titleText: String? = nil
    var name: String? = nil
    var latitude: String? = nil
    var longitude: String? = nil
    var radius: String? = nil
    var link: String? = nil
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = titleText
        nameTextField.text = name
        latitudeTextField.text = latitude
        longitudeTextField.text = longitude
        radiusTextField.text = radius
        linkTextField.text = link
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions
    @IBAction func currentLocationButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
    }

    @IBAction func cancelButtonClicked(sender: AnyObject) {
    }
}
