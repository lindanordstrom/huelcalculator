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
        var result = testObject.ActivityLevel.getActivityString(activity: .sedentary)
        XCTAssertEqual(result, Constants.User.sedentaryActive)

        result = testObject.ActivityLevel.getActivityString(activity: .lightly)
        XCTAssertEqual(result, Constants.User.lightlyActive)

        result = testObject.ActivityLevel.getActivityString(activity: .moderately)
        XCTAssertEqual(result, Constants.User.moderatelyActive)

        result = testObject.ActivityLevel.getActivityString(activity: .very)
        XCTAssertEqual(result, Constants.User.veryActive)

        result = testObject.ActivityLevel.getActivityString(activity: .extra)
        XCTAssertEqual(result, Constants.User.extraActive)

        result = testObject.ActivityLevel.getActivityString(activity: .count)
        XCTAssertEqual(result, Constants.User.selectActivity)
    }
}
