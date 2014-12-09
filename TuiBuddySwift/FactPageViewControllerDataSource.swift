//
//  FactPageViewControllerDataSource.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 05/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class FactPageViewControllerDataSource: NSObject, UIPageViewControllerDataSource {
    // The storyboard
    let _storyboard = UIStoryboard(name: "Main", bundle: nil)
    // The fact iterator
    var _facts: [Fact] = []
    var _viewControllers: [FactPageViewController] = []
    
    init(facts: [Fact]) {
        super.init()
        _facts = facts
        createViewControllers()
    }
    
    func createViewControllers() {
        for fact in _facts {
            if var factPageViewController = _storyboard.instantiateViewControllerWithIdentifier("factPageViewController") as? FactPageViewController {
                factPageViewController.fact = fact
                _viewControllers.append(factPageViewController)
            }
        }
    }
    
    func initialViewController() -> FactPageViewController? {
        if (_viewControllers.count > 0) {
            return _viewControllers[0]
        }
        return nil
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let factPageViewController = viewController as? FactPageViewController {
            if let index = find(_viewControllers, factPageViewController) {
                if index > 0 {
                    return _viewControllers[index - 1]
                }
            }
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let factPageViewController = viewController as? FactPageViewController {
            if let index = find(_viewControllers, factPageViewController) {
                if index < (_viewControllers.count - 1) {
                    return _viewControllers[index + 1]
                }
            }
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return _facts.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
