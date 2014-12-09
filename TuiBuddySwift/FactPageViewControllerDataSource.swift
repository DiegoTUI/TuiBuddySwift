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
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var _attraction: Attraction? = nil
    // The fact iterator
    var _factIterator: Iterator<Fact>? = nil
    
    init(attraction: Attraction) {
        super.init()
        _attraction = attraction
        _factIterator = _attraction!.factIterator()
    }
    
    func initialViewController() -> FactPageViewController? {
        if (_factIterator != nil && _factIterator!.current() != nil) {
            var factViewController: FactPageViewController? = storyboard.instantiateViewControllerWithIdentifier("factPageViewController") as? FactPageViewController
            if (factViewController != nil) {
                factViewController!.fact = _factIterator!.current()
            }
            return factViewController
        }
        return nil
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if (_factIterator != nil && _factIterator!.isPrev()) {
            var factViewController: FactPageViewController? = storyboard.instantiateViewControllerWithIdentifier("factPageViewController") as? FactPageViewController
            if (factViewController != nil) {
                factViewController!.fact = _factIterator!.prev()
            }
            return factViewController
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if (_factIterator != nil && _factIterator!.isNext()) {
            var factViewController: FactPageViewController? = storyboard.instantiateViewControllerWithIdentifier("factPageViewController") as? FactPageViewController
            if (factViewController != nil) {
                factViewController!.fact = _factIterator!.next()
            }
            return factViewController
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        if (_factIterator != nil) {
            return _factIterator!.count()
        }
        return 0
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
