//
//  MapUtilsTest.swift
//  IosAwnCore_Tests
//
//  Created by Rafael Setragni on 27/09/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import IosAwnCore

final class MapUtilsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDifferentElements() {
        let originalMap: [String: Any?] = ["key1": "value1", "key2": nil]
        let newMap: [String: Any?] = ["key3": "value3", "key4": ""]
        let mergedMap = MapUtils<[String: Any?]>.deepMerge(originalMap, newMap)
        
        XCTAssertEqual(originalMap["key1"] as? String, "value1")
        XCTAssertNil(originalMap["key2"]!)
        XCTAssertEqual(mergedMap["key1"] as? String, "value1")
        XCTAssertNil(mergedMap["key2"]!)
        XCTAssertEqual(mergedMap["key3"] as? String, "value3")
        XCTAssertEqual(mergedMap["key4"] as? String, "")
    }
    
    func testSameValues() {
        let originalMap: [String: Any?] = ["key1": "value1", "key2": nil]
        let newMap: [String: Any?] = ["key1": "newvalue1", "key2": ""]
        let mergedMap = MapUtils<[String: Any?]>.deepMerge(originalMap, newMap)
        
        XCTAssertEqual(originalMap["key1"] as? String, "value1")
        XCTAssertNil(originalMap["key2"]!)
        XCTAssertEqual(mergedMap["key1"] as? String, "newvalue1")
        XCTAssertEqual(mergedMap["key2"] as? String, "")
    }
    
    func testNestedMap() {
        let originalMap: [String: Any?] = ["key1": "value1", "payload": ["nestedKey1": "nestedValue1"]]
        let newMap: [String: Any?] = ["key1": "newvalue1", "payload": ["nestedKey1": nil, "nestedKey2": "nestedValue2"]]
        let mergedMap = MapUtils<[String: Any?]>.deepMerge(originalMap, newMap)
        
        XCTAssertEqual((originalMap["payload"] as? [String: String?])?["nestedKey1"], "nestedValue1")
        XCTAssertEqual((mergedMap["payload"] as? [String: String?])?["nestedKey1"]!, nil)
        XCTAssertEqual((mergedMap["payload"] as? [String: String?])?["nestedKey2"], "nestedValue2")
        XCTAssertEqual(mergedMap["key1"] as? String, "newvalue1")
    }

}
