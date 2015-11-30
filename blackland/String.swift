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
    
//    public subscript (Int) ->S
    
    
    //分割字符
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
    
    //去掉左右空格
    public func trim()->String{
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
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
    
}