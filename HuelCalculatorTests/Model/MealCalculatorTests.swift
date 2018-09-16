//
//  MealCalculatorTests.swift
//  HuelCalculatorTests
//
//  Created by Linda on 2018-04-19.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import XCTest
@testable import HuelCalculator

class MealCalculatorTests: XCTestCase {

    private var testObject = HuelMealCalculator.self

    func test_gramsToReachWithHuelUnflavouredShake() {
        let result = testObject.gramsToReach(calories: 814, product: HuelUnflavouredShake())
        XCTAssertEqual(result, 200)
    }

    func test_gramsToReachWithHuelVanillaShake() {
        let result = testObject.gramsToReach(calories: 800, product: HuelVanillaShake())
        XCTAssertEqual(result, 200)
    }

    func test_gramsToReachWithHuelBar() {
        let result = testObject.gramsToReach(calories: 764, product: HuelBar())
        XCTAssertEqual(result, 200)
    }

    func test_numberOfScoopsWithHuelUnflavouredShake() {
        let result = testObject.numberOfScoops(calories: 310, product: HuelUnflavouredShake())
        XCTAssertEqual(round(result), 2)
    }

    func test_numberOfScoopsWithHuelVanillaShake() {
        let result = testObject.numberOfScoops(calories: 304, product: HuelVanillaShake())
        XCTAssertEqual(round(result), 2)
    }

    func test_numberOfScoopsWithHuelBar() {
        let result = testObject.numberOfBars(calories: 500, product: HuelVanillaShake())
        XCTAssertEqual(round(result), 2)
    }
}
