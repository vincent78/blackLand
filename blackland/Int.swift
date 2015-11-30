//
//  Int.swift
//  blackland
//
//  Created by vincent on 15/11/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

import Foundation


// MARK: - Normal
public extension Int
{
    /**
     Calls function self times.
     
     :param: function Function to call
     */
    func times <T> (function: Void -> T) {
        (0..<self).each { _ in function(); return }
    }
    
    /**
     Calls function self times.
     
     :param: function Function to call
     */
    func times (function: Void -> Void) {
        (0..<self).each { _ in function(); return }
    }
    
    /**
     Calls function self times passing a value from 0 to self on each call.
     
     :param: function Function to call
     */
    func times <T> (function: (Int) -> T) {
        (0..<self).each { index in function(index); return }
    }
    
    
    
    /**
     Checks if a number is even.
     
     :returns: true if self is even
     */
    func isEven () -> Bool {
        return (self % 2) == 0
    }
    
    /**
     Checks if a number is odd.
     
     :returns: true if self is odd
     */
    func isOdd () -> Bool {
        return !isEven()
    }
    
    
    /**
     Absolute value.
     
     :returns: abs(self)
     */
    func abs () -> Int {
        return Swift.abs(self)
    }
    
    
    /**
     Random integer between min and max (inclusive).
     
     :param: min Minimum value to return
     :param: max Maximum value to return
     :returns: Random integer
     */
    static func random(min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}


// MARK: - NSTimeInterval conversion extensions
public extension Int {
    
    var years: NSTimeInterval {
        return 365 * self.days
    }
    
    var year: NSTimeInterval {
        return self.years
    }
    
    var days: NSTimeInterval {
        return 24 * self.hours
    }
    
    var day: NSTimeInterval {
        return self.days
    }
    
    var hours: NSTimeInterval {
        return 60 * self.minutes
    }
    
    var hour: NSTimeInterval {
        return self.hours
    }
    
    var minutes: NSTimeInterval {
        return 60 * self.seconds
    }
    
    var minute: NSTimeInterval {
        return self.minutes
    }
    
    var seconds: NSTimeInterval {
        return NSTimeInterval(self)
    }
    
    var second: NSTimeInterval {
        return self.seconds
    }
    
}
