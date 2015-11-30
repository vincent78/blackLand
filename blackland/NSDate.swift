//
//  NSDate.swift
//  blackland
//
//  Created by vincent on 15/11/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

import Foundation

public extension NSDate {
    
    // MARK:  NSDate Manipulation
    
    /**
    Returns a new NSDate object representing the date calculated by adding the amount specified to self date
    
    :param: seconds number of seconds to add
    :param: minutes number of minutes to add
    :param: hours number of hours to add
    :param: days number of days to add
    :param: weeks number of weeks to add
    :param: months number of months to add
    :param: years number of years to add
    :returns: the NSDate computed
    */
    public func add(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, months: Int = 0, years: Int = 0) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        
        let version = floor(NSFoundationVersionNumber)
        
        if version <= NSFoundationVersionNumber10_9_2 {
            var component = NSDateComponents()
            component.setValue(seconds, forComponent: .Second)
            var date : NSDate! = calendar.dateByAddingComponents(component,toDate: self,options: .WrapComponents)
            
            component = NSDateComponents()
            component.setValue(minutes, forComponent: .Minute)
            date = calendar.dateByAddingComponents(component, toDate: date, options: .WrapComponents)!
            
            component = NSDateComponents()
            component.setValue(hours, forComponent: .Hour)
            date = calendar.dateByAddingComponents(component, toDate: date, options: .WrapComponents)!
            
            component = NSDateComponents()
            component.setValue(days, forComponent: .Day)
            date = calendar.dateByAddingComponents(component, toDate: date, options: .WrapComponents)!
            
            component = NSDateComponents()
            component.setValue(months, forComponent: .Month)
            date = calendar.dateByAddingComponents(component, toDate: date, options: .WrapComponents)!
            
            component = NSDateComponents()
            component.setValue(years, forComponent: .Year)
            date = calendar.dateByAddingComponents(component, toDate: date, options: .WrapComponents)!
            return date
        }
        
        var date : NSDate! = calendar.dateByAddingUnit(.Second, value: seconds, toDate: self, options: .WrapComponents)
        date = calendar.dateByAddingUnit(.Minute, value: minutes, toDate: date, options: .WrapComponents)
        date = calendar.dateByAddingUnit(.Hour, value: hours, toDate: date, options: .WrapComponents)
        date = calendar.dateByAddingUnit(.Day, value: days, toDate: date, options: .WrapComponents)
        date = calendar.dateByAddingUnit(.Month, value: months, toDate: date, options: .WrapComponents)
        date = calendar.dateByAddingUnit(.Year, value: years, toDate: date, options: .WrapComponents)
        return date
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date
     
     :param: seconds number of seconds to add
     :returns: the NSDate computed
     */
    public func addSeconds (seconds: Int) -> NSDate {
        return add(seconds)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date
     
     :param: minutes number of minutes to add
     :returns: the NSDate computed
     */
    public func addMinutes (minutes: Int) -> NSDate {
        return add(minutes: minutes)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of hours to self date
     
     :param: hours number of hours to add
     :returns: the NSDate computed
     */
    public func addHours(hours: Int) -> NSDate {
        return add(hours: hours)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of days to self date
     
     :param: days number of days to add
     :returns: the NSDate computed
     */
    public func addDays(days: Int) -> NSDate {
        return add(days: days)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of months to self date
     
     :param: months number of months to add
     :returns: the NSDate computed
     */
    
    public func addMonths(months: Int) -> NSDate {
        return add(months: months)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of years to self date
     
     :param: years number of year to add
     :returns: the NSDate computed
     */
    public func addYears(years: Int) -> NSDate {
        return add(years: years)
    }
    
    // MARK:  Date comparison
    
    /**
    Checks if self is after input NSDate
    
    :param: date NSDate to compare
    :returns: True if self is after the input NSDate, false otherwise
    */
    public func isAfter(date: NSDate) -> Bool{
        return (self.compare(date) == NSComparisonResult.OrderedDescending)
    }
    
    /**
     Checks if self is before input NSDate
     
     :param: date NSDate to compare
     :returns: True if self is before the input NSDate, false otherwise
     */
    public func isBefore(date: NSDate) -> Bool{
        return (self.compare(date) == NSComparisonResult.OrderedAscending)
    }
    
    
    // MARK: Getter
    
    /**
    Date year
    */
    public var year : Int {
        get {
            return getComponent(.Year)
        }
    }
    
    /**
     Date month
     */
    public var month : Int {
        get {
            return getComponent(.Month)
        }
    }

    
    
    /**
     Date days
     */
    public var days : Int {
        get {
            return getComponent(.Day)
        }
    }
    
    /**
     Date hours
     */
    public var hours : Int {
        
        get {
            return getComponent(.Hour)
        }
    }
    
    /**
     Date minuts
     */
    public var minutes : Int {
        get {
            return getComponent(.Minute)
        }
    }
    
    /**
     Date seconds
     */
    public var seconds : Int {
        get {
            return getComponent(.Second)
        }
    }
    
    /**
     Returns the value of the NSDate component
     
     :param: component NSCalendarUnit
     :returns: the value of the component
     */
    
    public func getComponent (component : NSCalendarUnit) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(component, fromDate: self)
        return components.valueForComponent(component)
    }
}

// MARK: - 类型转换
public extension NSDate
{
    /**
     转成字符串
     
     - parameter format: <#format description#>
     
     - returns: <#return value description#>
     */
    public func toString(format : String? = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        if let fmt = format {
            dateFmt.dateFormat = fmt
        }
        return dateFmt.stringFromDate(self);
        
    }
    
    /**
     转成毫秒数
     
     - returns: <#return value description#>
     */
    public func toMilliSecond() -> Double {
        return self.timeIntervalSince1970 * 1000;
    }
    
}





public func +(date: NSDate, timeInterval: Int) -> NSDate {
    return date + NSTimeInterval(timeInterval)
}

public func -(date: NSDate, timeInterval: Int) -> NSDate {
    return date - NSTimeInterval(timeInterval)
}

public func +=(inout date: NSDate, timeInterval: Int) {
    date = date + timeInterval
}

public func -=(inout date: NSDate, timeInterval: Int) {
    date = date - timeInterval
}

public func +(date: NSDate, timeInterval: Double) -> NSDate {
    return date.dateByAddingTimeInterval(NSTimeInterval(timeInterval))
}

public func -(date: NSDate, timeInterval: Double) -> NSDate {
    return date.dateByAddingTimeInterval(NSTimeInterval(-timeInterval))
}

public func +=(inout date: NSDate, timeInterval: Double) {
    date = date + timeInterval
}

public func -=(inout date: NSDate, timeInterval: Double) {
    date = date - timeInterval
}

public func -(date: NSDate, otherDate: NSDate) -> NSTimeInterval {
    return date.timeIntervalSinceDate(otherDate)
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
}
