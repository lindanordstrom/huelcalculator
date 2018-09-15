//
//  UserTests.swift
//  HuelCalculatorTests
//
//  Created by Linda on 2018-04-19.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import XCTest
@testable import HuelCalculator

class UserTests: XCTestCase {

    private var testObject = User.self
    
    func test_getActivityString() {
        var result = testObject.ActivityLevel.sedentary.description
        XCTAssertEqual(result, Constants.User.sedentaryActive)

        result = testObject.ActivityLevel.lightly.description
        XCTAssertEqual(result, Constants.User.lightlyActive)

        result = testObject.ActivityLevel.moderately.description
        XCTAssertEqual(result, Constants.User.moderatelyActive)

        result = testObject.ActivityLevel.very.description
        XCTAssertEqual(result, Constants.User.veryActive)

        result = testObject.ActivityLevel.extra.description
        XCTAssertEqual(result, Constants.User.extraActive)
        
        result = testObject.ActivityLevel.count.description
        XCTAssertEqual(result, "")
    }
    
    func test_count() {
        let result = testObject.ActivityLevel.itemCount
        XCTAssertEqual(result, 5)
    }
    
    func test_itemAtIndex() {
        var result = testObject.ActivityLevel.itemAt(rawValue: 0) as? User.ActivityLevel
        XCTAssertEqual(result, testObject.ActivityLevel.sedentary)
        
        result = testObject.ActivityLevel.itemAt(rawValue: 1)  as? User.ActivityLevel
        XCTAssertEqual(result, testObject.ActivityLevel.lightly)
        
        result = testObject.ActivityLevel.itemAt(rawValue: 2)  as? User.ActivityLevel
        XCTAssertEqual(result, testObject.ActivityLevel.moderately)
        
        result = testObject.ActivityLevel.itemAt(rawValue: 3)  as? User.ActivityLevel
        XCTAssertEqual(result, testObject.ActivityLevel.very)
        
        result = testObject.ActivityLevel.itemAt(rawValue: 4)  as? User.ActivityLevel
        XCTAssertEqual(result, testObject.ActivityLevel.extra)
        
        result = testObject.ActivityLevel.itemAt(rawValue: 5)  as? User.ActivityLevel
        XCTAssertEqual(result, testObject.ActivityLevel.count)
        
        result = testObject.ActivityLevel.itemAt(rawValue: 6)  as? User.ActivityLevel
        XCTAssertNil(result)
    }
}
