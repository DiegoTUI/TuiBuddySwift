//
//  AttractionsTableViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 07/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

extension UITableViewController {
    override func isVisible() -> Bool {
        return self.isViewLoaded() && (self.tableView.window != nil)
    }
}

extension UIViewController {
    func isVisible() -> Bool {
        return self.isViewLoaded() && (self.view.window != nil)
    }
}

class AttractionsTableViewController: UITableViewController, AddEditAttractionViewControllerDelegate, NotificationHandler {

    var _alertViewShowing = false
    var attractions = AttractionManager.sharedInstance.readAttractions()
    // Notification handler protocol
    var shouldShow = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // add "add button"
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewAttraction:")
        self.navigationItem.rightBarButtonItem = addButton
        // add "debug" button
        if config.debug {
            let debugButton = UIBarButtonItem(title: "Debug", style: .Plain, target: self, action: Selector("debugButtonClicked"))
            self.navigationItem.leftBarButtonItem = debugButton
        }
        // Delegate and data source
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Become delegate of RegionManager
        RegionManager.sharedInstance.startMonitoringRegions()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Attractions"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNewAttraction(sender: AnyObject) {
        self.performSegueWithIdentifier("addAttraction", sender: nil)
    }
    
    // MARK: - Actions
    
    func debugButtonClicked () {
        performSegueWithIdentifier("showDebug", sender: nil)
    }
    
    // MARK: - Notification Handler
    
    func handleNotificationForAttraction(attraction: Attraction) {
        performSegueWithIdentifier(config.notificationSegueName, sender: attraction.name)
    }
    
    // MARK: - AddEditAttractionViewControllerDelegate
    
    func attractionAdded (attractionRow: Int?) {
        attractions = AttractionManager.sharedInstance.readAttractions()
        let action = (attractionRow == nil) ? self.tableView.insertRowsAtIndexPaths : self.tableView.reloadRowsAtIndexPaths
        let row = (attractionRow == nil) ? countElements(attractions) - 1 : attractionRow!
        action([NSIndexPath(forRow: row, inSection: 0)], withRowAnimation: .Automatic)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // deal with segue
        if segue.identifier == "showFacts" {
            // sender is the title of the cell
            let attraction = attractions.filter({$0.name == (sender as String)})[0]
            let attractionFactViewController = (segue.destinationViewController as UINavigationController).viewControllers[0] as AttractionFactViewController
            AttractionFactViewController.factIterator = attraction.iterator()
        } else if segue.identifier == "addAttraction" {
            // stop updating locations
            RegionManager.sharedInstance.stopMonitoringRegions()
            let destinationViewController = segue.destinationViewController as AddEditAttractionViewController
            destinationViewController.titleText = "Add Attraction"
            destinationViewController.delegate = self
        } else if segue.identifier == "editAttraction" {
            // stop updating locations
            RegionManager.sharedInstance.stopMonitoringRegions()
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(config.notificationSegueName, sender: tableView.cellForRowAtIndexPath(indexPath)?.textLabel.text)
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
            AttractionManager.sharedInstance.deleteAttraction(self.attractions[indexPath.row])
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
