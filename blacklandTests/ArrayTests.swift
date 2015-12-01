//
//  ArrayTests.swift
//  blackland
//
//  Created by vincent on 15/12/1.
//  Copyright © 2015年 fruit. All rights reserved.
//

import XCTest
@testable import blackland
class ArrayTests: XCTestCase {
    
    var intArray: [Int] = []
    var stringArray: [String] = []

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.intArray = [Int](1...5)
        self.stringArray = ["A", "B", "C", "D", "E", "F"]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testGetInBounds()
    {
        for i in self.intArray.enumerate() {
            XCTAssertEqual(self.intArray.get(i.index), i.element)
        }
    }
    
    func testGetOutBounds() {
        XCTAssertEqual(self.intArray.get(-1), nil)
        XCTAssertEqual(self.intArray.get(self.intArray.count), nil)
    }
    
    func testSortUsing() {
        XCTAssertEqual(self.intArray.sortUsing { $0 }, [1, 2, 3, 4, 5])
        XCTAssertEqual(self.intArray.sortUsing { $0 % 2 }, [2, 4, 1, 3, 5])
        XCTAssertEqual(self.intArray.sortUsing { -$0 }, self.intArray.reverse())
    }
    
    func testReject() {
        XCTAssertEqual(self.intArray.reject { _ in true }, [])
        XCTAssertEqual(self.intArray.reject { _ in false }, self.intArray)
        XCTAssertEqual(self.intArray.reject { obj in obj > 3 }, [1, 2, 3])
        XCTAssertEqual(self.intArray.reject { obj in obj % 2 == 0 }, [1, 3, 5])
    }
    
    func testEach() {
        var data1 = [Int]()
        
        self.intArray.each { data1.append($0) }
        
        XCTAssertEqual(self.intArray, data1)
        
        var data2 = [Int]()
        
        self.intArray.each { index, obj in data2.append(index) }
        
        XCTAssertEqual(data2, [Int](0...4))
    }
    
    func testContains() {
        XCTAssertTrue(self.intArray.contains(3))
        XCTAssertFalse(self.intArray.contains(10))
        
        XCTAssertTrue(self.intArray.contains(1,2))
        XCTAssertFalse(self.intArray.contains(1,10))
        XCTAssertFalse(self.intArray.contains(6,7,8))
    }
    
    
    func testIndexOf() {
        XCTAssertEqual(self.intArray.indexOf(1), 0)
        XCTAssertEqual(self.intArray.indexOf(5), 4)
        
        XCTAssertEqual(self.intArray.indexOf(self.intArray[2]), 2)
        XCTAssertEqual(self.intArray.indexOf(50), nil)
        
        XCTAssertEqual(self.intArray.indexOf { $0 % 2 == 0 }, 1)
        
        XCTAssertEqual(self.intArray.indexOf { $0 > 10 }, nil)
    }
    
    func testLastIndexOf() {
        let arrayWithDuplicates: [Int] = [1, 1, 2, 2, 3, 4, 1]
        
        XCTAssertEqual(arrayWithDuplicates.lastIndexOf(1), 6)
        XCTAssertEqual(arrayWithDuplicates.lastIndexOf(4), 5)
        XCTAssertEqual(arrayWithDuplicates.lastIndexOf(arrayWithDuplicates[2]), 3)
        XCTAssertEqual(arrayWithDuplicates.lastIndexOf(50), nil)
    }
    
    func testMax() {
        XCTAssertEqual(self.intArray.max() as Int, 5)
    }
    
    func testMin() {
        XCTAssertEqual(self.intArray.min() as Int, 1)
    }
    
    func testAt() {
        XCTAssertEqual(self.intArray.at(0, 2), [1,3])
        XCTAssertEqual(self.intArray[0, 2, 1], [1,3,2])
    }
    
    func testUnique() {
        let arrayWithDuplicates = [1, 1, 2, 2, 3, 4]
        XCTAssertEqual(arrayWithDuplicates.unique() as [Int], [1,2,3,4])
        XCTAssertEqual(arrayWithDuplicates.uniqueBy { $0 }, arrayWithDuplicates.unique())
        
        XCTAssertEqual(arrayWithDuplicates.uniqueBy { $0 % 2 }, [1, 2])
        XCTAssertEqual(arrayWithDuplicates.uniqueBy { $0 % 3 }, [1,2,3])
        XCTAssertEqual(arrayWithDuplicates.uniqueBy { $0 < 3 }, [1,3])
        
    }
    
    func testTake() {
        XCTAssertEqual(self.intArray.take(2), self.intArray[0..<2])
        XCTAssertEqual(self.intArray.take(0), [])
        XCTAssertEqual(self.intArray.take(6), self.intArray)
        XCTAssertEqual(self.intArray.take(-1), [])
        XCTAssertEqual(self.intArray.takeWhile { $0 < 3 }, [1,2])
        XCTAssertEqual(self.intArray.takeWhile { $0 % 2 == 0 }, [])
    }
    
    func testSkip() {
        XCTAssertEqual(self.intArray.skip(2), self.intArray[2..<self.intArray.count])
        XCTAssertEqual(self.intArray.skip(0), self.intArray)
        XCTAssertEqual(self.intArray.skip(6), [])
        XCTAssertEqual(self.intArray.skip(-1), self.intArray)
        XCTAssertEqual(self.intArray.skipWhile { $0 < 3 }, [3,4,5])
        XCTAssertEqual(self.intArray.skipWhile{ $0 % 2 == 0 }, self.intArray)
        XCTAssertEqual(self.intArray.skipWhile{ $0 > 0}, [])
    }
    
    func testCountBy() {
        let count_1 = self.intArray.countBy {
            return $0 % 2 == 0 ? "even" : "odd"
        }
        
        XCTAssertEqual(count_1, ["even": 2, "odd": 3])
        
        let count_2 = self.intArray.countBy { param -> Int in
            return 0
        }
        
        XCTAssertEqual(count_2, [0: self.intArray.count])
    }
    
    func testDifference() {
        XCTAssertEqual(self.intArray.difference([3,4]), [1,2,5])
        XCTAssertEqual(self.intArray.difference([3],[4]), [1,2,5])
        XCTAssertEqual(self.intArray.difference([]), [1,2,3,4,5])
        
        XCTAssertEqual(self.intArray-[3,4], [1,2,5])
        XCTAssertEqual(self.intArray-[3]-[4], [1,2,5])
        XCTAssertEqual(self.intArray-[], [1,2,3,4,5])
        
    }
    
    func testUnion() {
//        XCTAssertEqual(self.intArray.union([]), self.intArray)
        XCTAssertEqual(self.intArray.union([1]), self.intArray)
        XCTAssertEqual(self.intArray.union([1, 5], [6], [7, 4]), [1, 2, 3, 4, 5, 6, 7])
        
        XCTAssertEqual(self.intArray | [], self.intArray)
        XCTAssertEqual(self.intArray | [1], self.intArray)
        XCTAssertEqual(self.intArray | [1, 5] | [6] | [7, 4], [1, 2, 3, 4, 5, 6, 7])
        
    }
    
    func testDuplication() {
        XCTAssertEqual([1]*3, [1,1,1])
        XCTAssertEqual(self.intArray * 0, [])
        XCTAssertEqual(self.intArray * 1, self.intArray)
    }
    
    func testTail() {
        XCTAssertEqual(self.intArray.tail(2), [4,5])
        XCTAssertEqual(self.intArray.tail(10), self.intArray)
        XCTAssertEqual(self.intArray.tail(0), [])
    }
    
    func testToDictionary() {
        let dic = self.intArray.toDictionary { return  "number\($0)"
        }
        for i in self.intArray.enumerate() {
            XCTAssertEqual(i.element, dic["number\(i.element)"])
        }
        
        let dic1 = self.intArray.toDictionary { (element) -> (Int,String)? in
            if element > 2 {
                return nil
            }
            return (element, "number \(element)")
            
        }
        
        XCTAssertEqual(dic1[1], "number 1")
        XCTAssertEqual(dic1[2], "number 2")
        XCTAssertEqual(dic1.keys.count ,2)
        
    }
    
 

}
