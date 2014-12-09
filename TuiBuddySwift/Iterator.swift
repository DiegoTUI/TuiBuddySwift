//
//  Iterator.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 03/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

// a generic iterator

class Iterator <T:Equatable> {
    var current: () -> T? = {return nil}
    var next: () -> T? = {return nil}
    var prev: () -> T? = {return nil}
    var isPrev: () -> Bool = {return false}
    var isNext: () -> Bool = {return false}
    var count: () -> Int = {return 0}
    
    init(items: [T]) {
        var currentItem: T? = (countElements(items) > 0) ? items[0] : nil
        // current
        self.current = {[unowned self]() in
            return currentItem
        }
        // next
        self.next = {[unowned self]() in
            if currentItem == nil {
                return nil
            }
            if let index = find(items, currentItem!) {
                if index < countElements(items) - 1 {
                    currentItem = items[index + 1]
                    return currentItem
                }
                return nil
            }
            return nil
        }
        // isNext
        self.isNext = {[unowned self]() in
            if currentItem == nil {
                return false
            }
            if let index = find(items, currentItem!) {
                if index < countElements(items) - 1 {
                    return true
                }
                return false
            }
            return false
        }
        // prev
        self.prev = {[unowned self]() in
            if currentItem == nil {
                return nil
            }
            if let index = find(items, currentItem!) {
                if index > 0 {
                    currentItem = items[index - 1]
                    return currentItem
                }
                return nil
            }
            return nil
        }
        // isPrev
        self.isPrev = {[unowned self]() in
            if currentItem == nil {
                return false
            }
            if let index = find(items, currentItem!) {
                if index > 0 {
                    return true
                }
                return false
            }
            return false
        }
        // count
        self.count = {[unowned self]() in
            return items.count
        }
    }
}
