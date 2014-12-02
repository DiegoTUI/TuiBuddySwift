//
//  AttractionsCollectionViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 02/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

let reuseIdentifier = "AttractionCell"

class AttractionsCollectionViewController: UICollectionViewController {
    
    // attractions in the collection view
    var _attractions = AttractionManager.sharedInstance.readAttractions()
    // should the controller show alerts?
    var shouldShow = true
    // is there an alert view showing?
    var _alertViewShowing = false
    // layout constants
    let kTopOffset = 20.0
    let kLeftOffset = 10.0
    let kRightOffset = 10.0
    let kBetweenCellsOffset = 5.0
    let kCellHeight = 90.0
    var cellWidth = 375.0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView.registerClass(AttractionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        cellWidth = Double(self.view.frame.size.width) - kLeftOffset - kRightOffset
        // set contextual menu
        let editMenuItem = UIMenuItem(title: "Edit", action: "editMenuOptionClicked:")
        let deleteMenuItem = UIMenuItem(title: "Delete", action: "deleteMenuOptionClicked:")
        UIMenuController.sharedMenuController().menuItems = [editMenuItem, deleteMenuItem]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return _attractions.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as AttractionViewCell
    
        // Configure the cell
        let attraction = _attractions[indexPath.row] as Attraction
        cell.titleLabel.text = attraction.name
    
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(CGFloat(cellWidth), CGFloat(kCellHeight))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(CGFloat(cellWidth), CGFloat(kTopOffset))
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = kBlueColor
    }
    
    override func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = kWhiteColor
    }

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        if (action == "editMenuOptionClicked:" || action == "deleteMenuOptionClicked:") {
            return true
        }
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        println("perform action: \(action)")
    }
    
    

}
