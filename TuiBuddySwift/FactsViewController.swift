//
//  FactsViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 09/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController, NotificationHandler {
    // should the controller show alerts?
    var shouldShow = true
    // outlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var pageContainerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    // the attraction
    var attraction: Attraction? = nil
    // the page view controller
    var pageViewController: UIPageViewController? = nil
    var pageViewControllerDataSource: FactPageViewControllerDataSource? = nil
    // The storyboard
    let _storyboard = UIStoryboard(name: "Main", bundle: nil)
    // Layout
    let kContainerVerticalOffset: CGFloat = 20.0
    let kContainerHorizontalOffset: CGFloat = 15.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // load background image
        loadBackgroundImage()
        // load pageView Controller
        pageViewControllerDataSource = FactPageViewControllerDataSource(facts: attraction!.facts, frame: CGRect(x: 0, y: 0, width: view.frame.width - 2.0*kContainerHorizontalOffset, height: view.frame.height - 2.0*kContainerVerticalOffset))
        pageViewController!.dataSource = self.pageViewControllerDataSource
        
        let startingViewController: FactPageViewController = self.pageViewControllerDataSource!.initialViewController()!
        let viewControllers: NSArray = [startingViewController]
        pageViewController!.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: false, completion: nil)
        // set background view color
        backgroundView.backgroundColor = kTransparentBlueColor
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadBackgroundImage() {
        mainImageView.image = UIImage(named: "background_\(attraction!.id)")
    }
    
    func resizeImage(image: UIImage?, toSize: CGSize) -> UIImage? {
        if (image == nil) {
            return nil
        }
        UIGraphicsBeginImageContext(view.frame.size);
        image!.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        //here is the scaled image which has been changed to the size specified
        UIGraphicsEndImageContext();
        return newImage
    }
    
    // MARK: segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "factPagesContainer" {
            pageViewController = segue.destinationViewController as? UIPageViewController
        }
    }
    
    // MARK: actions
    
    @IBAction func closeButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Notification Handler
    
    func handleNotificationForAttraction(attraction: Attraction) {
        self.attraction = attraction
        self.viewDidLoad()
    }
}
