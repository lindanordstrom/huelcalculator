//
//  CalorieDistributionPresenterTests.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import XCTest
@testable import HuelCalculator

class CalorieDistributionPresenterTests: XCTestCase {

    private var testObject: CalorieDistributionPresenter!
    private var mockedView: MockedCalorieDistributionUI!
    private var userManager: MockedUserManager!

    override func setUp() {
        super.setUp()
        mockedView = MockedCalorieDistributionUI()
        userManager = MockedUserManager()
        testObject = CalorieDistributionPresenter(view: mockedView, userManager: userManager)
        userManager.user = User(preferredUnitOfMeasurement: nil, age: nil, gender: nil, height: nil, weight: nil, goal: nil, activityLevel: nil)
    }

    override func tearDown() {
        testObject = nil
        mockedView = nil
        userManager = nil
        super.tearDown()
    }


    /** Given:
     *  When:  update user consumption is called
     *  Then:  The userManager updates the user with the correct calorie distributions
     */
    func test_updateUserConsumption() {
        testObject.updateUserConsumption(breakfast: 20, lunch: 30, dinner: 40, snack: 50)

        XCTAssertTrue(userManager.distributeCaloriesCalled)
        XCTAssertEqual(userManager.calorieDistribution?.breakfast, 20)
        XCTAssertEqual(userManager.calorieDistribution?.lunch, 30)
        XCTAssertEqual(userManager.calorieDistribution?.dinner, 40)
        XCTAssertEqual(userManager.calorieDistribution?.snack, 50)
    }

    /** Given: The signed in user has updated the calorie distribution
     *  And:   The used amount of calories do not exceed the daily consumption
     *  When:  The input fields gets updated
     *  Then:  The UI is updated with correct calorie amounts
     *  And:   The UI label color is set to black
     */
    func test_updateInputField() {
        userManager.user?.calorieDistribution = CalorieDistribution(dailyCalorieConsumption: 2010, breakfast: 500, lunch: 500, dinner: 500, snack: 500)

        testObject?.updateInputFields()

        XCTAssertTrue(mockedView.setRemainingCaloriesLabelBlackCalled)
        XCTAssertEqual(mockedView.remainingCalories, 10)
        XCTAssertEqual(mockedView.breakfastCalories, 500)
        XCTAssertEqual(mockedView.lunchCalories, 500)
        XCTAssertEqual(mockedView.dinnerCalories, 500)
        XCTAssertEqual(mockedView.snackCalories, 500)
    }

    /** Given: The signed in user has updated the calorie distribution
     *  And:   The used amount of calories exceeds the daily consumption
     *  When:  The input fields gets updated
     *  Then:  The UI is updated with correct calorie amounts
     *  And:   The UI label color is set to red
     */
    func test_updateInputFieldWhenUsedCaloriesExceedsDailyConsumption() {
        userManager.user?.calorieDistribution = CalorieDistribution(dailyCalorieConsumption: 1990, breakfast: 500, lunch: 500, dinner: 500, snack: 500)

        testObject?.updateInputFields()

        XCTAssertTrue(mockedView.setRemainingCaloriesLabelRedCalled)
        XCTAssertEqual(mockedView.remainingCalories, -10)
        XCTAssertEqual(mockedView.breakfastCalories, 500)
        XCTAssertEqual(mockedView.lunchCalories, 500)
        XCTAssertEqual(mockedView.dinnerCalories, 500)
        XCTAssertEqual(mockedView.snackCalories, 500)
    }

    /** Given:
     *  When:  User presses the "split equally" button
     *  Then:  The remaining calories will be split equally into the fields with the "remainder" calories added to Dinner
     */
    func test_didPressSplitEquallyButton() {
        userManager.user?.calorieDistribution = CalorieDistribution(dailyCalorieConsumption: 403, breakfast: nil, lunch: nil, dinner: nil, snack: nil)

        testObject?.didPressSplitEquallyButton()

        XCTAssertTrue(userManager.distributeCaloriesCalled)
        XCTAssertEqual(userManager.calorieDistribution?.breakfast, 100)
        XCTAssertEqual(userManager.calorieDistribution?.lunch, 100)
        XCTAssertEqual(userManager.calorieDistribution?.dinner, 103)
        XCTAssertEqual(userManager.calorieDistribution?.snack, 100)
    }

    /** Given: User does not have any calorie consumtion
     *  When:  User presses the "split equally" button
     *  Then:  distribute calories should not be called
     */
    func test_didPressSplitEquallyButtonWhenNoDailyCalorieConsumptionExists() {
        testObject?.didPressSplitEquallyButton()

        XCTAssertFalse(userManager.distributeCaloriesCalled)
        XCTAssertEqual(userManager.calorieDistribution?.breakfast, nil)
    }

    /** Given: Remaining calories are 0
     *  When:  Asked if the controller should show the meal plan page
     *  Then:  true should be returned
     *  And:   No warning should be displayed
     */
    func test_shouldShowMealPlanPage_remainingCaloriesZero() {
        let result = testObject.shouldShowMealPlanPage(remainingCalories: 0)

        XCTAssertFalse(mockedView.showPopupWarningCalled)
        XCTAssertTrue(result)
    }

    /** Given: Remaining calories are more than 0
     *  When:  Asked if the controller should show the meal plan page
     *  Then:  false should be returned
     *  And:   A warning with remaining calories should be displayed
     */
    func test_shouldShowMealPlanPage_remainingCaloriesMoreThanZero() {
        let result = testObject.shouldShowMealPlanPage(remainingCalories: 1)

        XCTAssertTrue(mockedView.showPopupWarningCalled)
        XCTAssertFalse(result)
        XCTAssertEqual(mockedView.remainingCalories, 1)
    }

    /** Given: Remaining calories are less than 0
     *  When:  Asked if the controller should show the meal plan page
     *  Then:  false should be returned
     *  And:   A warning with remaining calories should be displayed
     */
    func test_shouldShowMealPlanPage_remainingCaloriesLessThanZero() {
        let result = testObject.shouldShowMealPlanPage(remainingCalories: -1)

        XCTAssertTrue(mockedView.showPopupWarningCalled)
        XCTAssertFalse(result)
        XCTAssertEqual(mockedView.remainingCalories, -1)
    }

    /** Given: Remaining calories are nil
     *  When:  Asked if the controller should show the meal plan page
     *  Then:  false should be returned
     */
    func test_shouldShowMealPlanPage_remainingCaloriesNil() {
        let result = testObject.shouldShowMealPlanPage(remainingCalories: nil)

        XCTAssertFalse(mockedView.showPopupWarningCalled)
        XCTAssertFalse(result)
    }
}


