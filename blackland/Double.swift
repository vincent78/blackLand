//
//  Double.swift
//  blackland
//
//  Created by vincent on 15/11/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

import Foundation
public extension Double {
    
    /**
     Absolute value.
     
     :returns: fabs(self)
     */
    public func abs () -> Double {
        return Foundation.fabs(self)
    }
    
    /**
     Squared root.
     
     :returns: sqrt(self)
     */
    public func sqrt () -> Double {
        return Foundation.sqrt(self)
    }
    
    /**
     Rounds self to the largest integer <= self.
     
     :returns: floor(self)
     */
    public func floor () -> Double {
        return Foundation.floor(self)
    }
    
    /**
     Rounds self to the smallest integer >= self.
     
     :returns: ceil(self)
     */
    public func ceil () -> Double {
        return Foundation.ceil(self)
    }
    
    /**
     Rounds self to the nearest integer.
     
     :returns: round(self)
     */
    public func round () -> Double {
        return Foundation.round(self)
    }
    
    /**
     Clamps self to a specified range.
     
     :param: min Lower bound
     :param: max Upper bound
     :returns: Clamped value
     */
    public func clamp (min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }
    
    /**
     Just like round(), except it supports rounding to an arbitrary number, not just 1
     Be careful about rounding errors
     
     :params: increment the increment to round to
     */
    public func roundToNearest(increment: Double) -> Double {
        let remainder = self % increment
        return remainder < increment / 2 ? self - remainder : self - remainder + increment
    }
    
    /**
     Random double between min and max (inclusive).
     
     :params: min
     :params: max
     :returns: Random number
     */
    public static func random(min: Double = 0, max: Double) -> Double {
        let diff = max - min;
        let rand = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Double(RAND_MAX)) * diff) + min;
    }
    
}

// MARK: - 类型转换
public extension Double
{
    /**
     毫秒数转成日期
     
     - returns: <#return value description#>
     */
    public func toDate() -> NSDate {
        return NSDate(timeIntervalSince1970: (self/1000));
    }
    
    
    public func toString() -> String {
        return String(self)
    }
}
