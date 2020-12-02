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

    func test_gramsToReachWithHuelShake() {
        let result = testObject.gramsToReach(calories: 800, product: HuelShake())
        XCTAssertEqual(result, 200)
    }

    func test_gramsToReachWithHuelBlackEditionShake() {
        let result = testObject.gramsToReach(calories: 800, product: HuelBlackEditionShake())
        XCTAssertEqual(round(result), 180)
    }

    func test_gramsToReachWithHuelBar() {
        let result = testObject.gramsToReach(calories: 200, product: HuelBar())
        XCTAssertEqual(round(result), 49)
    }

    func test_numberOfScoopsWithHueldShake() {
        let result = testObject.numberOfScoops(calories: 400, product: HuelShake())
        XCTAssertEqual(String(format: "%.1f", result), "2.0")
    }

    func test_numberOfScoopsWithHuelBlackEditionShake() {
        let result = testObject.numberOfScoops(calories: 400, product: HuelBlackEditionShake())
        XCTAssertEqual(String(format: "%.1f", result), "2.0")
    }

    func test_numberOfScoopsWithHuelBar() {
        let result = testObject.numberOfBars(calories: 500, product: HuelBar())
        XCTAssertEqual(String(format: "%.1f", result), "2.5")
    }
    
    func test_numberOfBottlesWithHuelReadyToDrink() {
        let result = testObject.numberOfReadyToDrinkBottles(calories: 600, product: HuelReadyToDrink())
        XCTAssertEqual(String(format: "%.1f", result), "1.5")
    }
    
    func test_numberOfScoopsWithHuelHotAndSavoury() {
        let result = testObject.numberOfScoops(calories: 400, product: HuelHotAndSavoury())
        XCTAssertEqual(String(format: "%.1f", result), "2.0")
    }
}
