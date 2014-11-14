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

class AttractionsTableViewController: UITableViewController, AddEditAttractionViewControllerDelegate, RegionManagerDelegate, UIPopoverPresentationControllerDelegate {

    var _alertViewShowing = false
    var attractions = AttractionManager.sharedInstance.readAttractions()
    
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
        //Delegate and data source
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Become deleagte of RegionManager
        RegionManager.sharedInstance.delegate = self
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
        /*println("debug button clicked")
        var popoverContent = self.storyboard!.instantiateViewControllerWithIdentifier("debug") as DebugViewController
        var nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        var popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSizeMake(200,300)
        popover!.delegate = self
        popover!.sourceView = self.view
        popover!.sourceRect = CGRectMake(100,100,0,0)
        
        self.presentViewController(nav, animated: true, completion: nil)*/
        performSegueWithIdentifier("showDebug", sender: nil)
    }
    
    // MARK: - AddEditAttractionViewControllerDelegate
    
    func attractionAdded (attractionRow: Int?) {
        attractions = AttractionManager.sharedInstance.readAttractions()
        let action = (attractionRow == nil) ? self.tableView.insertRowsAtIndexPaths : self.tableView.reloadRowsAtIndexPaths
        let row = (attractionRow == nil) ? countElements(attractions) - 1 : attractionRow!
        action([NSIndexPath(forRow: row, inSection: 0)], withRowAnimation: .Automatic)
    }
    
    // MARK: - RegionManagerDelegate
    
    func didEnterRegion(attractionId: Int32) {
        println("Entered region: \(attractionId)")
        // find attraction
        let attraction = attractions.filter({$0.id == attractionId})[0]
        let message = "Check out these cool facts about \(attraction.name)!!"
        // check if background or foreground
        if UIApplication.sharedApplication().applicationState == .Background {
            // launch local notification
            NotificationManager.sendLocalNotificationForAttraction(attraction, withMessage: message)
        }
        else if config.showAlerts && isVisible() && !_alertViewShowing {
            // app in foreground. Show UIAlert only if config.showAlerts is true and this is the visible view controller, and there are no alerts being showed so far
            var alert = UIAlertController(title: "Hey!!", message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "No, thanks", style: .Cancel, handler: {[unowned self] action in
                self._alertViewShowing = false}))
            alert.addAction(UIAlertAction(title: "OK!!", style: .Default, handler:{[unowned self] action in
                self.performSegueWithIdentifier("showInfo", sender: attraction.name)
                self._alertViewShowing = false}))
            self.presentViewController(alert, animated: true, completion: nil)
            _alertViewShowing = true
        }
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // deal with segue
        if segue.identifier == "showInfo" {
            // sender is the title of the cell
            let attraction = attractions.filter({$0.name == (sender as String)})[0]
            (segue.destinationViewController as AttractionInfoViewController).url = attraction.url
            (segue.destinationViewController as AttractionInfoViewController).navigationTitle = (sender as String)
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
        performSegueWithIdentifier("showInfo", sender: tableView.cellForRowAtIndexPath(indexPath)?.textLabel.text)
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
