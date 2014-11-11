//
//  AddEditAttractionViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 07/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

extension String {
    // Calculates if a string can be converted to double
    func isDouble() -> Bool {
        let scanner = NSScanner(string: self)
        return scanner.scanDouble(nil) && scanner.scanLocation == countElements(self)
    }
    // Double value of string
    var double:Double {
        return (self as NSString).doubleValue
    }
}

protocol AddEditAttractionViewControllerDelegate {
    func attractionAdded()
}

class AddEditAttractionViewController: UIViewController, UITextFieldDelegate {
    
    var titleText: String? = nil
    var attraction: Attraction? = nil
    var delegate:AddEditAttractionViewControllerDelegate? = nil
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // assign title
        titleLabel.text = titleText
        // assign text (if attraction)
        if attraction != nil {
            nameTextField.text = attraction!.name
            latitudeTextField.text = String(format:"%f", attraction!.latitude)
            longitudeTextField.text = String(format:"%f", attraction!.longitude)
            radiusTextField.text = String(format:"%f", attraction!.radius)
            linkTextField.text = attraction!.link
        }
        // delegates to hide keyboard
        nameTextField.delegate = self
        latitudeTextField.delegate = self
        longitudeTextField.delegate = self
        radiusTextField.delegate = self
        linkTextField.delegate = self
        // Tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        self.view.addGestureRecognizer(tapGestureRecognizer)
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
    
    // MARK: - Check text fields
    func checkTextFieldForDouble(textField: UITextField) -> Bool {
        if textField.text.isDouble() {
            textField.layer.borderColor = UIColor.blackColor().CGColor
            return true
        } else {
            textField.layer.borderColor = UIColor.redColor().CGColor
            return false
        }
    }
    
    func checkTextFieldForEmpty(textField: UITextField) -> Bool {
        if countElements(textField.text) > 0 {
            textField.layer.borderColor = UIColor.blackColor().CGColor
            return true
        } else {
            textField.layer.borderColor = UIColor.redColor().CGColor
            return false
        }
    }
    
    // MARK: - Actions
    @IBAction func currentLocationButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        // check for errors in numeric fields
        var save:Bool = true
        save = checkTextFieldForDouble(latitudeTextField) && save
        save = checkTextFieldForDouble(longitudeTextField) && save
        save = checkTextFieldForDouble(radiusTextField) && save
        // check for empty fields
        save = checkTextFieldForEmpty(nameTextField) && save
        save = checkTextFieldForEmpty(linkTextField) && save
        
        if save {
            attraction = Attraction(name: nameTextField.text,
                latitude: latitudeTextField.text.double,
                longitude: longitudeTextField.text.double,
                radius: radiusTextField.text.double,
                link: linkTextField.text)
            SqliteManager.sharedInstance.writeAttraction(attraction!)
            self.dismissViewControllerAnimated(true, completion: nil)
            delegate?.attractionAdded()
        }
        else {
            var alert = UIAlertController(title: "Alert", message: "Some of the fields are incorrect. Please check.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    @IBAction func cancelButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - TextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Keyboard
    func hideKeyboard() {
        self.view.endEditing(true)
    }
}
