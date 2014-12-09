//
//  FactsViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 09/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // load background image
        loadBackgroundImage()
        // load pageView Controller
        pageViewControllerDataSource = FactPageViewControllerDataSource(facts: attraction!.facts)
        pageViewController!.dataSource = self.pageViewControllerDataSource
        
        let startingViewController: FactPageViewController = self.pageViewControllerDataSource!.initialViewController()!
        let viewControllers: NSArray = [startingViewController]
        pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
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
}
