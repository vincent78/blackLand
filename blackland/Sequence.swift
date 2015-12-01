//
//  Sequence.swift
//  blackland
//
//  Created by vincent on 15/12/1.
//  Copyright © 2015年 fruit. All rights reserved.
//

import Foundation

public extension AnySequence {
    
    /**
     Checks if self contains the item object.
     
     :param: item The item to search for
     :returns: true if self contains item
     */
    func contains<T:Equatable> (item: T) -> Bool {
        let generator =  self.generate()
        while let nextItem = generator.next() {
            if nextItem as! T == item {
                return true
            }
        }
        return false
    }
    
    
    
    /**
     Index of the first occurrence of item, if found.
     
     :param: item The item to search for
     :returns: Index of the matched item or nil
     */
    func indexOf <U: Equatable> (item: U) -> Int? {
        var index = 0
        for current in self {
            if let equatable = current as? U {
                if equatable == item {
                    return index
                }
            }
            index++
        }
        return nil
    }

}