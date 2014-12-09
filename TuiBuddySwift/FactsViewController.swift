//
//  FactsViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 09/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController {
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
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewControllerDataSource = FactPageViewControllerDataSource(attraction: self.attraction!)
        pageViewController!.dataSource = self.pageViewControllerDataSource
        
        let startingViewController: FactPageViewController = self.pageViewControllerDataSource!.initialViewController()!
        let viewControllers: NSArray = [startingViewController]
        pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 20, view.frame.size.width, view.frame.size.height);
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
}
