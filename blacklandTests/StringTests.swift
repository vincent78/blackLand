//
//  StringTests.swift
//  blackland
//
//  Created by vincent on 15/11/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

import XCTest
@testable import blackland
class StringTests: XCTestCase {
    var strs = ["Hello World","测试Abc19","😱","∞","∞aA","∆Test😗","∆"]
    var len  = [11,7,1,1,3,6,1]

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLength() {
        for (var i = 0 ;i<strs.count;i++)
        {
            XCTAssertEqual(strs[i].length, len[i]);
        }
        
    }

    func testSubStr () {
        let string = "∆Test😗"
        XCTAssertEqual(string[0...1], "∆T")
        XCTAssertEqual(string[0...0], "∆")
        
    }
    
    func testSplit() {
        let tmp = "this is test sample"
        let tmpArray = tmp.split(" ")
        XCTAssertEqual(tmpArray.count, 4)
        XCTAssertEqual(tmpArray[0], "this")
        XCTAssertEqual(tmpArray[3], "sample")
        
    }
    
    
    
    func testReverse() {
        let tmp = " this is test sample "
        XCTAssertEqual(tmp.reverse(), " elpmas tset si siht ")
    }
    
    func testToDateTime() {
        print("2015-11-30 15:30:50".toDate("yyyy-MM-dd HH:mm:ss"))
    }
    
    
}
