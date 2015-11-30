//
//  Float.swift
//  blackland
//
//  Created by vincent on 15/11/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

import Foundation
public extension Float {
    
    /**
     Absolute value.
     
     :returns: fabs(self)
     */
    public func abs () -> Float {
        return fabsf(self)
    }
    
    /**
     Squared root.
     
     :returns: sqrtf(self)
     */
    public func sqrt () -> Float {
        return sqrtf(self)
    }
    
    /**
     Rounds self to the largest integer <= self.
     
     :returns: floorf(self)
     */
    public func floor () -> Float {
        return floorf(self)
    }
    
    /**
     Rounds self to the smallest integer >= self.
     
     :returns: ceilf(self)
     */
    public func ceil () -> Float {
        return ceilf(self)
    }
    
    /**
     Rounds self to the nearest integer.
     
     :returns: roundf(self)
     */
    public func round () -> Float {
        return roundf(self)
    }
    
    /**
     Clamps self to a specified range.
     
     :param: min Lower bound
     :param: max Upper bound
     :returns: Clamped value
     */
    public func clamp (min: Float, _ max: Float) -> Float {
        return Swift.max(min, Swift.min(max, self))
    }
    
    /**
     Random float between min and max (inclusive).
     
     :param: min
     :param: max
     :returns: Random number
     */
    public static func random(min: Float = 0, max: Float) -> Float {
        let diff = max - min;
        let rand = Float(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Float(RAND_MAX)) * diff) + min;
    }
    
}

