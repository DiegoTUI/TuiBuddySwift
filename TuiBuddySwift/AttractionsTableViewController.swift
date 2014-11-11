//
//  AttractionsTableViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 07/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class AttractionsTableViewController: UITableViewController, AddEditAttractionViewControllerDelegate {

    var attractions = SqliteManager.sharedInstance.readAttractions()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewAttraction:")
        self.navigationItem.rightBarButtonItem = addButton
        //Delegate and data source
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNewAttraction(sender: AnyObject) {
        self.performSegueWithIdentifier("addAttraction", sender: nil)
    }
    
    // MARK: - AddEditAttractionViewControllerDelegate
    
    func attractionAdded (attractionRow: Int?) {
        attractions = SqliteManager.sharedInstance.readAttractions()
        let action = (attractionRow == nil) ? self.tableView.insertRowsAtIndexPaths : self.tableView.reloadRowsAtIndexPaths
        let row = (attractionRow == nil) ? countElements(attractions) - 1 : attractionRow!
        action([NSIndexPath(forRow: row, inSection: 0)], withRowAnimation: .Automatic)
    }
    
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                /*let object = objects[indexPath.row] as NSDate
                (segue.destinationViewController as DetailViewController).detailItem = object*/
            }
        } else if segue.identifier == "addAttraction" {
            let destinationViewController = segue.destinationViewController as AddEditAttractionViewController
            destinationViewController.titleText = "Add Attraction"
            destinationViewController.delegate = self
        } else if segue.identifier == "editAttraction" {
            let destinationViewController = segue.destinationViewController as AddEditAttractionViewController
            destinationViewController.titleText = "Edit Attraction"
            destinationViewController.attraction = attractions[(sender as NSIndexPath).row]
            destinationViewController.attractionRow = (sender as NSIndexPath).row
            destinationViewController.delegate = self
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let attraction = attractions[indexPath.row] as Attraction
        cell.textLabel.text = attraction.name
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {}
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit", handler:{[unowned self](action, indexPath) in
            println("EDIT•ACTION");
            // TODO: perform segue to detail view controller
            self.performSegueWithIdentifier("editAttraction", sender: indexPath)
        });
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{[unowned self](action, indexPath) in
            println("DELETE•ACTION");
            SqliteManager.sharedInstance.deleteAttraction(self.attractions[indexPath.row])
            self.attractions.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        });
        
        return [deleteRowAction, moreRowAction];
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

}
