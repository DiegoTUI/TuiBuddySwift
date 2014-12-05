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
    // The attraction
    var attraction: Attraction? = nil
    // The fact iterator
    var _factIterator: Iterator<Fact>? = nil
    
    init(attraction: Attraction) {
        super.init()
        self.attraction = attraction
        _factIterator = attraction.factIterator()
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if (_factIterator != nil && _factIterator!.isPrev()) {
            var factViewController: FactViewController? = storyboard.instantiateViewControllerWithIdentifier("factViewController") as? FactViewController
            if (factViewController != nil) {
                factViewController!.fact = _factIterator!.prev()
            }
            return factViewController
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if (_factIterator != nil && _factIterator!.isNext()) {
            var factViewController: FactViewController? = storyboard.instantiateViewControllerWithIdentifier("factViewController") as? FactViewController
            if (factViewController != nil) {
                factViewController!.fact = _factIterator!.next()
            }
            return factViewController
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        if (attraction != nil) {
            return attraction!.facts.count
        }
        return 0
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
