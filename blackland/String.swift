//
//  String.swift
//  blackland
//
//  Created by vincent on 15/11/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

import Foundation


// MARK: - Normal
public extension String
{
    /// 长度
    public var length: Int {
        return self.characters.count
    }
    
    
    /**
     取子串
     Returns the substring in the given range
     
     :param: range
     :returns: Substring in range
     */
    public subscript (range: Range<Int>) -> String? {
        if range.startIndex < 0 || range.endIndex > self.length {
            return nil
        }
        
        let range = Range(start: startIndex.advancedBy(range.startIndex), end: startIndex.advancedBy(range.endIndex - range.startIndex))
        return self[range]
    }
    
    public subscript (index: Int) ->String? {
        return self[index...index]
    }
    
    
    /**
    分割字符
    
    - parameter s: <#s description#>
    
    - returns: <#return value description#>
    */
    public func split(s:String)->[String]{
        if s.isEmpty{
            var x=[String]()
            for y in self.characters{
                x.append(String(y))
            }
            return x
        }
        return self.componentsSeparatedByString(s)
    }
    
    /**
     去掉左右空格
     
     - returns: <#return value description#>
     */
    public func trim(characterSet set: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet())->String{
        return self.stringByTrimmingCharactersInSet(set)
    }
    
    /**
     Strips the specified characters from the beginning of self.
     
     :returns: Stripped string
     */
    public func trimLeft (characterSet set: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()) -> String {
        if let range = rangeOfCharacterFromSet(set.invertedSet) {
            return self[range.startIndex..<endIndex]
        }
        
        return ""
    }
    
    public func trimRight (characterSet set: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()) -> String {
        if let range = rangeOfCharacterFromSet(set.invertedSet, options: NSStringCompareOptions.BackwardsSearch) {
            return self[startIndex..<range.endIndex]
        }
        
        return ""
    }
    
    //是否包含字符串
    public func has(s:String)->Bool{
        if (self.rangeOfString(s) != nil) {
            return true
        }else{
            return false
        }
    }
    
//    //是否包含前缀
//    public func isBegin(s:String)->Bool{
//        if self.hasPrefix(s) {
//            return true
//        }else{
//            return false
//        }
//    }
//    //是否包含后缀
//    public func isEnd(s:String)->Bool{
//        if self.hasSuffix(s) {
//            return true
//        }else{
//            return false
//        }
//    }
    
    //反转
    public func reverse()-> String{
        let s=self.split("").reverse()
        var x=""
        for y in s{
            x+=y
        }
        return x
    }
    /**
     在字符串中按index添加子串
     
     - parameter index:  <#index description#>
     - parameter string: <#string description#>
     
     - returns: <#return value description#>
     */
    public func insert (index: Int, _ string: String) -> String {
        //  Edge cases, prepend and append
        if index > length {
            return self + string
        } else if index < 0 {
            return string + self
        }
        
        return self[0..<index]! + string + self[index..<length]!
    }
    
    /**
     随机生成字符串
     
     - parameter len:     字符串的长度  如果为0 则在0~16位中随机取
     - parameter charset: <#charset description#>
     
     - returns: <#return value description#>
     */
    public static func random (var length len: Int = 0, charset: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        
        if len < 1 {
            len = Int.random(max: 16)
        }
        
        var result = String()
        let max = charset.length - 1
        
        len.times {
            result = result + charset[Int.random(0, max: max)]!
        }
        
        return result
        
    }
    
}

// MARK: - Regex
public extension String
{
    public func matches (pattern: String, ignoreCase: Bool = false) -> [NSTextCheckingResult]? {
        return nil
    }
    
    
    public func containsMatch (pattern: String, ignoreCase: Bool = false) -> Bool? {
        return false
    }
    
    public func replaceMatches (pattern: String, withString replacementString: String, ignoreCase: Bool = false) -> String?
    {
        return nil
    }
}

// MARK: - 类型转换
public extension String
{
    /**
     Parses a string containing a double numerical value into an optional double if the string is a well formed number.
     
     :returns: A double parsed from the string or nil if it cannot be parsed.
     */
    public func toDouble() -> Double? {
        
        let scanner = NSScanner(string: self)
        var double: Double = 0
        
        if scanner.scanDouble(&double) {
            return double
        }
        
        return nil
        
    }
    
    /**
     Parses a string containing a float numerical value into an optional float if the string is a well formed number.
     
     :returns: A float parsed from the string or nil if it cannot be parsed.
     */
    public func toFloat() -> Float? {
        
        let scanner = NSScanner(string: self)
        var float: Float = 0
        
        if scanner.scanFloat(&float) {
            return float
        }
        
        return nil
        
    }
    
    /**
     Parses a string containing a boolean value (true or false) into an optional Bool if the string is a well formed.
     
     :returns: A Bool parsed from the string or nil if it cannot be parsed as a boolean.
     */
    public func toBool() -> Bool? {
        let text = self.trim().lowercaseString
        if text == "true" || text == "false" || text == "yes" || text == "no" {
            return (text as NSString).boolValue
        }
        
        return nil
    }
    
    /**
     Parses a string containing a non-negative integer value into an optional UInt if the string is a well formed number.
     
     :returns: A UInt parsed from the string or nil if it cannot be parsed.
     */
    public func toUInt() -> UInt? {
        if let val = Int(self.trim()) {
            if val < 0 {
                return nil
            }
            return UInt(val)
        }
        
        return nil
    }
    
    /**
     Parses a string containing a date into an optional NSDate if the string is a well formed.
     The default format is yyyy-MM-dd, but can be overriden.
     
     :returns: A NSDate parsed from the string or nil if it cannot be parsed as a date.
     */
    public func toDate(format : String? = "yyyy-MM-dd") -> NSDate? {
        let text = self.trim().lowercaseString
        let dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        if let fmt = format {
            dateFmt.dateFormat = fmt
        }
        return dateFmt.dateFromString(text)
    }
    
    /**
     Parses a string containing a date and time into an optional NSDate if the string is a well formed.
     The default format is yyyy-MM-dd hh-mm-ss, but can be overriden.
     
     :returns: A NSDate parsed from the string or nil if it cannot be parsed as a date.
     */
    public func toDateTime(format : String? = "yyyy-MM-dd hh-mm-ss") -> NSDate? {
        return toDate(format)
    }


}