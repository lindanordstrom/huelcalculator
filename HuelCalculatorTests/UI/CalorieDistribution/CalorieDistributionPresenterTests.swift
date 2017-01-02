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
    
    private var testObject: CalorieDistributionPresenter?
    private var mockedView: CalorieDistributionMock?
    
    override func setUp() {
        super.setUp()
        testObject = CalorieDistributionPresenter()
        mockedView = CalorieDistributionMock()
        testObject?.set(view: mockedView!)
    }
    
    override func tearDown() {
        testObject = nil
        mockedView = nil
        super.tearDown()
    }
    
    /** Given: User enters a number in any field
     *  When:  The focus leaves the input field
     *  Then:  The remaining calories decreases with the same amount will be displayed in black
     */
    func test_didUpdateInputField() {
        testObject?.didUpdateInputField(dailyConsumtion: 500, breakfast: "10", lunch: "20", dinner: "", snack: "")
        XCTAssertTrue(mockedView!.setRemainingCaloriesLabelBlackCalled)
        XCTAssert(mockedView?.remainingCalories == 470)
    }
    
    /** Given: User enters a number larger than the remaining calories in any field
     *  When:  The focus leaves the input field
     *  Then:  The remaining calories decreases with the same amount and the negative amount will be displayed in red
     */
    func test_didUpdateInputField_caloriesExceeded() {
        testObject?.didUpdateInputField(dailyConsumtion: 500, breakfast: "10", lunch: "491", dinner: "", snack: "")
        XCTAssertTrue(mockedView!.setRemainingCaloriesLabelRedCalled)
        XCTAssert(mockedView?.remainingCalories == -1)
    }
    
    /** Given: User presses the "split equally" button
     *  When:  -
     *  Then:  The remaining calories will be split equally into the fields with the "remainder" calories added to Dinner
     */
    func test_didPressSplitEquallyButton() {
        testObject?.didPressSplitEquallyButton(calories: 403)
        XCTAssert(mockedView?.breakfastCalories == 100)
        XCTAssert(mockedView?.lunchCalories == 100)
        XCTAssert(mockedView?.dinnerCalories == 103)
        XCTAssert(mockedView?.snackCalories == 100)
    }
    
    /** Given: User presses the "next" button
     *  When:  Remaining calories is 0
     *  Then:  The next view is displayed
     */
    func test_didPressNextButton_remainingCaloriesZero() {
        testObject?.didPressNextButton(remainingCalories: "0")
        XCTAssertTrue(mockedView!.navigateToMealPlanViewControllerCalled)
    }
    
    /** Given: User presses the "next" button
     *  When:  Remaining calories is more than 0
     *  Then:  The a warning popup with remaining calories is displayed
     */
    func test_didPressNextButton_remainingCaloriesMoreThanZero() {
        testObject?.didPressNextButton(remainingCalories: "1")
        XCTAssertTrue(mockedView!.showPopupWarningCalled)
        XCTAssert(mockedView?.remainingCalories == 1)
    }
    
    /** Given: User presses the "next" button
     *  When:  Remaining calories is less than 0
     *  Then:  The a warning popup with remaining calories is displayed
     */
    func test_didPressNextButton_remainingCaloriesLessThanZero() {
        testObject?.didPressNextButton(remainingCalories: "-1")
        XCTAssertTrue(mockedView!.showPopupWarningCalled)
        XCTAssert(mockedView?.remainingCalories == -1)
    }
}

private class CalorieDistributionMock: CalorieDistributionPresentable {
    
    var navigateToMealPlanViewControllerCalled = false
    var setRemainingCaloriesLabelRedCalled = false
    var setRemainingCaloriesLabelBlackCalled = false
    var showPopupWarningCalled = false
    var breakfastCalories: Int?
    var lunchCalories: Int?
    var dinnerCalories: Int?
    var snackCalories: Int?
    var remainingCalories: Int?
    
    func navigateToMealPlanViewController() {
        navigateToMealPlanViewControllerCalled = true
    }
    
    func setRemainingCaloriesLabel(calories: Int) {
        remainingCalories = calories
    }
    
    func setBreakfastCaloriesInputField(calories: Int) {
        breakfastCalories = calories
    }
    
    func setLunchCaloriesInputField(calories: Int) {
        lunchCalories = calories
    }
    
    func setDinnerCaloriesInputField(calories: Int) {
        dinnerCalories = calories
    }
    
    func setSnackCaloriesInputField(calories: Int) {
        snackCalories = calories
    }
    
    func setRemainingCaloriesLabelRed() {
        setRemainingCaloriesLabelRedCalled = true
    }
    
    func setRemainingCaloriesLabelBlack() {
        setRemainingCaloriesLabelBlackCalled = true
    }
    
    func showPopupWarning(remainingCalories: Int) {
        self.remainingCalories = remainingCalories
        showPopupWarningCalled = true
    }
}
