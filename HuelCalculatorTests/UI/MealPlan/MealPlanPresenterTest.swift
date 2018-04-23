//
//  MealPlanPresenterTest.swift
//  HuelCalculator
//
//  Created by Linda on 10/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import XCTest
@testable import HuelCalculator

class MealPlanPresenterTest: XCTestCase {

    private var testObject: MealPlanPresenter!
    private var ui: MockedMealPlanUI!
    private var userManager: MockedUserManager!

    override func setUp() {
        super.setUp()
        ui = MockedMealPlanUI()
        userManager = MockedUserManager()
        testObject = MealPlanPresenter(view: ui, userManager: userManager)

        userManager.user = User(preferredUnitOfMeasurement: .metric, age: 30, gender: .male, height: 177, weight: 60, goal: .lose, activityLevel: .moderately)
        userManager.user?.calorieDistribution = CalorieDistribution(dailyCalorieConsumption: 2000, breakfast: 100, lunch: 200, dinner: 300, snack: 400)
    }

    override func tearDown() {
        ui = nil
        userManager = nil
        testObject = nil
        super.tearDown()
    }

    /** Given: User has distributed calories
     *  When:  Page is loaded and flavour system is "unflavoured"
     *  Then:  The calories will be calculated to scoops/grams of unflavoured HUEL
     */
    func test_didLoadView_unflavoured() {
        testObject.didLoadView(with: HuelUnflavouredShake())

        XCTAssertEqual(ui?.breakfastAmount, "25 g / 0.6 scoops\n123 ml water\nTotal: 100 kcal")
        XCTAssertEqual(ui?.lunchAmount, "49 g / 1.3 scoops\n246 ml water\nTotal: 200 kcal")
        XCTAssertEqual(ui?.dinnerAmount, "74 g / 1.9 scoops\n369 ml water\nTotal: 300 kcal")
        XCTAssertEqual(ui?.snackAmount, "98 g / 2.6 scoops\n491 ml water\nTotal: 400 kcal")
    }

    /** Given: User has distributed calories
     *  When:  Page is loaded and flavour system is "vanilla"
     *  Then:  The calories will be calculated to scoops/grams of vanilla HUEL
     */
    func test_didLoadView_vanilla() {
        testObject.didLoadView(with: HuelVanillaShake())

        XCTAssertEqual(ui?.breakfastAmount, "25 g / 0.7 scoops\n125 ml water\nTotal: 100 kcal")
        XCTAssertEqual(ui?.lunchAmount, "50 g / 1.3 scoops\n250 ml water\nTotal: 200 kcal")
        XCTAssertEqual(ui?.dinnerAmount, "75 g / 2.0 scoops\n375 ml water\nTotal: 300 kcal")
        XCTAssertEqual(ui?.snackAmount, "100 g / 2.6 scoops\n500 ml water\nTotal: 400 kcal")
    }

    /** Given: User has distributed calories
     *  When:  Page is loaded and flavour system is "bar"
     *  Then:  The calories will be calculated to grams and number of HUEL bars
     */
    func test_didLoadView_bar() {
        testObject.didLoadView(with: HuelBar())

        XCTAssertEqual(ui?.breakfastAmount, "0.4 bars / 26 g\nTotal: 100 kcal")
        XCTAssertEqual(ui?.lunchAmount, "0.8 bars / 52 g\nTotal: 200 kcal")
        XCTAssertEqual(ui?.dinnerAmount, "1.2 bars / 79 g\nTotal: 300 kcal")
        XCTAssertEqual(ui?.snackAmount, "1.6 bars / 105 g\nTotal: 400 kcal")
    }

    /** Given: No signed in user exists
     *  When:  Page is loaded
     *  Then:  Nothing should happen
     */
    func test_didLoadView_noSignedInUser() {
        userManager.user = nil
        testObject.didLoadView(with: HuelBar())

        XCTAssertEqual(ui?.breakfastAmount, nil)
        XCTAssertEqual(ui?.lunchAmount, nil)
        XCTAssertEqual(ui?.dinnerAmount, nil)
        XCTAssertEqual(ui?.snackAmount, nil)
    }

    /** Given: User doesn't have any calorie distribution
     *  When:  Page is loaded
     *  Then:  Nothing should happen
     */
    func test_didLoadView_noCalorieDistribution() {
        userManager.user?.calorieDistribution = CalorieDistribution()
        testObject.didLoadView(with: HuelBar())

        XCTAssertEqual(ui?.breakfastAmount, nil)
        XCTAssertEqual(ui?.lunchAmount, nil)
        XCTAssertEqual(ui?.dinnerAmount, nil)
        XCTAssertEqual(ui?.snackAmount, nil)
    }
}

