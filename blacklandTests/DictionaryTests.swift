//
//  DictionaryTests.swift
//  blackland
//
//  Created by vincent on 15/12/1.
//  Copyright © 2015年 fruit. All rights reserved.
//

import XCTest
@testable import blackland
class DictionaryTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testToStr() {
        let dic = ["id":1,"name":"test1"]
        XCTAssertEqual(dic.toJSONStr(), "{\"id\":1,\"name\":\"test1\"}")
    }
    
    

}
