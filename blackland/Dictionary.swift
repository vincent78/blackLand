//
//  Dictionary.swift
//  blackland
//
//  Created by vincent on 15/11/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

import Foundation


public extension Dictionary {
    
    /**
     Difference of self and the input dictionaries.
     Two dictionaries are considered equal if they contain the same [key: value] pairs.
     
     :param: dictionaries Dictionaries to subtract
     :returns: Difference of self and the input dictionaries
     */
    public func difference <V: Equatable> (dictionaries: [Key: V]...) -> [Key: V] {
        
        var result = [Key: V]()
        
        each {
            if let item = $1 as? V {
                result[$0] = item
            }
        }
        
        //  Difference
        for dictionary in dictionaries {
            for (key, value) in dictionary {
                if result.has(key) && result[key] == value {
                    result.removeValueForKey(key)
                }
            }
        }
        
        return result
        
    }
    
    /**
     Union of self and the input dictionaries.
     
     :param: dictionaries Dictionaries to join
     :returns: Union of self and the input dictionaries
     */
    public func union (dictionaries: Dictionary...) -> Dictionary {
        
        var result = self
        
        dictionaries.each { (dictionary) -> Void in
            dictionary.each { (key, value) -> Void in
                _ = result.updateValue(value, forKey: key)
            }
        }
        
        return result
        
    }
    
    /**
     Intersection of self and the input dictionaries.
     Two dictionaries are considered equal if they contain the same [key: value] copules.
     
     :param: values Dictionaries to intersect
     :returns: Dictionary of [key: value] couples contained in all the dictionaries and self
     */
    func intersection <K, V where K: Equatable, V: Equatable> (dictionaries: [K: V]...) -> [K: V] {
        
        //  Casts self from [Key: Value] to [K: V]
        let filtered = mapFilter { (item, value) -> (K, V)? in
            if (item is K) && (value is V) {
                return (item as! K, value as! V)
            }
            
            return nil
        }
        
        //  Intersection
        return filtered.filter({ (key: K, value: V) -> Bool in
            //  check for [key: value] in all the dictionaries
            dictionaries.all { $0.has(key) && $0[key] == value }
        })
        
    }
    
    /**
     Checks if a key exists in the dictionary.
     
     :param: key Key to check
     :returns: true if the key exists
     */
    public func has (key: Key) -> Bool {
        return indexForKey(key) != nil
    }
    
    /**
     Creates an Array with values generated by running
     each [key: value] of self through the mapFunction.
     
     :param: mapFunction
     :returns: Mapped array
     */
    public func toArray <V> (map: (Key, Value) -> V) -> [V] {
        
        var mapped = [V]()
        
        each {
            mapped.append(map($0, $1))
        }
        
        return mapped
        
    }
    
    /**
     Creates a Dictionary with the same keys as self and values generated by running
     each [key: value] of self through the mapFunction.
     
     :param: mapFunction
     :returns: Mapped dictionary
     */
    public func mapValues <V> (map: (Key, Value) -> V) -> [Key: V] {
        
        var mapped = [Key: V]()
        
        each {
            mapped[$0] = map($0, $1)
        }
        
        return mapped
        
    }
    
    /**
     Creates a Dictionary with the same keys as self and values generated by running
     each [key: value] of self through the mapFunction discarding nil return values.
     
     :param: mapFunction
     :returns: Mapped dictionary
     */
    public func mapFilterValues <V> (map: (Key, Value) -> V?) -> [Key: V] {
        
        var mapped = [Key: V]()
        
        each {
            if let value = map($0, $1) {
                mapped[$0] = value
            }
        }
        
        return mapped
        
    }
    
    /**
     Creates a Dictionary with keys and values generated by running
     each [key: value] of self through the mapFunction discarding nil return values.
     
     :param: mapFunction
     :returns: Mapped dictionary
     */
    public func mapFilter <K, V> (map: (Key, Value) -> (K, V)?) -> [K: V] {
        
        var mapped = [K: V]()
        
        each {
            if let value = map($0, $1) {
                mapped[value.0] = value.1
            }
        }
        
        return mapped
        
    }
    
    /**
     Creates a Dictionary with keys and values generated by running
     each [key: value] of self through the mapFunction.
     
     :param: mapFunction
     :returns: Mapped dictionary
     */
    public func map <K, V> (map: (Key, Value) -> (K, V)) -> [K: V] {
        
        var mapped = [K: V]()
        
        each({
            let (_key, _value) = map($0, $1)
            mapped[_key] = _value
        })
        
        
        return mapped
        
    }
    
    /**
     Loops trough each [key: value] pair in self.
     
     :param: eachFunction Function to inovke on each loop
     */
    public func each (each: (Key, Value) -> ()) {
        
        for (key, value) in self {
            each(key, value)
        }
        
    }
    
    /**
     Constructs a dictionary containing every [key: value] pair from self
     for which testFunction evaluates to true.
     
     :param: testFunction Function called to test each key, value
     :returns: Filtered dictionary
     */
    public func filter (test: (Key, Value) -> Bool) -> Dictionary {
        
        var result = Dictionary()
        
        each { (key, value) -> () in
            if test(key, value) {
                result[key] = value
            }
        }
        
        return result
        
    }
    
    /**
     Creates a dictionary composed of keys generated from the results of
     running each element of self through groupingFunction. The corresponding
     value of each key is an array of the elements responsible for generating the key.
     
     :param: groupingFunction
     :returns: Grouped dictionary
     */
    public func groupBy <T> (group: (Key, Value) -> T) -> [T: [Value]] {
        
        var result = [T: [Value]]()
        
        for (key, value) in self {
            
            let groupKey = group(key, value)
            
            // If element has already been added to dictionary, append to it. If not, create one.
            if result.has(groupKey) {
                result[groupKey]! += [value]
            } else {
                result[groupKey] = [value]
            }
            
        }
        
        return result
    }
    
    /**
     Similar to groupBy. Doesn't return a list of values, but the number of values for each group.
     
     :param: groupingFunction Function called to define the grouping key
     :returns: Grouped dictionary
     */
    public func countBy <T> (group: (Key, Value) -> (T)) -> [T: Int] {
        
        var result = [T: Int]()
        
        for (key, value) in self {
            
            let groupKey = group(key, value)
            
            // If element has already been added to dictionary, append to it. If not, create one.
            if result.has(groupKey) {
                result[groupKey]!++
            } else {
                result[groupKey] = 1
            }
        }
        
        return result
    }
    
    /**
     Checks if test evaluates true for all the elements in self.
     
     :param: test Function to call for each element
     :returns: true if test returns true for all the elements in self
     */
    public func all (test: (Key, Value) -> (Bool)) -> Bool {
        
        for (key, value) in self {
            if !test(key, value) {
                return false
            }
        }
        
        return true
        
    }
    
    /**
     Checks if test evaluates true for any element of self.
     
     :param: test Function to call for each element
     :returns: true if test returns true for any element of self
     */
    public func any (test: (Key, Value) -> (Bool)) -> Bool {
        
        for (key, value) in self {
            if test(key, value) {
                return true
            }
        }
        
        return false
        
    }
    
    
    /**
     Returns the number of elements which meet the condition
     
     :param: test Function to call for each element
     :returns: the number of elements meeting the condition
     */
    public func countWhere (test: (Key, Value) -> (Bool)) -> Int {
        
        var result = 0
        
        for (key, value) in self {
            if test(key, value) {
                result++
            }
        }
        
        return result
    }
    
    

    
    /**
     Returns a copy of self, filtered to only have values for the whitelisted keys.
     
     :param: keys Whitelisted keys
     :returns: Filtered dictionary
     */
    public func pick (keys: [Key]) -> Dictionary {
        return filter { (key: Key, _) -> Bool in
            return keys.contains(key)
        }
    }
    
    /**
     Returns a copy of self, filtered to only have values for the whitelisted keys.
     
     :param: keys Whitelisted keys
     :returns: Filtered dictionary
     */
    public func pick (keys: Key...) -> Dictionary {
        return pick(unsafeBitCast(keys, [Key].self))
    }
    
    /**
     Returns a copy of self, filtered to only have values for the whitelisted keys.
     
     :param: keys Keys to get
     :returns: Dictionary with the given keys
     */
    public func at (keys: Key...) -> Dictionary {
        return pick(keys)
    }
    
    /**
     Removes a (key, value) pair from self and returns it as tuple.
     If the dictionary is empty returns nil.
     
     :returns: (key, value) tuple
     */
    public mutating func shift () -> (Key, Value)? {
        if let key = keys.first {
            return (key, removeValueForKey(key)!)
        }
        
        return nil
    }
    
}

// MARK: - JSON
public extension Dictionary {
    
    /**
     转换成JSON字符串
     
     - returns: <#return value description#>
     */
    public func toJSONStr() -> String? {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(self as! AnyObject, options: NSJSONWritingOptions(rawValue:0))
            return String(data: jsonData, encoding: NSUTF8StringEncoding)
        } catch {
            return nil
        }
    }
}


/**
 Difference operator
 */
public func - <K, V: Equatable> (first: [K: V], second: [K: V]) -> [K: V] {
    return first.difference(second)
}

/**
 Intersection operator
 */
public func & <K, V: Equatable> (first: [K: V], second: [K: V]) -> [K: V] {
    return first.intersection(second)
}

/**
 Union operator
 */
public func | <K: Hashable, V> (first: [K: V], second: [K: V]) -> [K: V] {
    return first.union(second)
}