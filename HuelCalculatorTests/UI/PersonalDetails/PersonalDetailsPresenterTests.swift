//
//  PersonalDetailsPresenterTests.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import XCTest
@testable import HuelCalculator

class PersonalDetailsPresenterTest: XCTestCase {
    
    private var testObject: PersonalDetailsPresenter?
    private var mockedView: PersonalDetailsMock?
    
    override func setUp() {
        super.setUp()
        testObject = PersonalDetailsPresenter()
        mockedView = PersonalDetailsMock()
        testObject?.set(view: mockedView!)
    }
    
    override func tearDown() {
        testObject = nil
        mockedView = nil
        super.tearDown()
    }
    
    /** Given: User selects metric unit system
     *  When:  -
     *  Then:  height and weight is shown in kg/cm
     */
    func test_didChangeMeasurementValue_metric() {
        testObject?.didChangeMeasurementValue(value: User.UnitOfMeasurement.metric)
        
        XCTAssertTrue(mockedView!.updateUIToMetricSystemCalled, "updateUIToMetricSystem was not called")
    }
    
    /** Given: User selects imperial unit system
     *  When:  -
     *  Then:  height and weight is shown in lb/feet
     */
    func test_didChangeMeasurementValue_imperial() {
        testObject?.didChangeMeasurementValue(value: User.UnitOfMeasurement.imperial)
        
        XCTAssertTrue(mockedView!.updateUIToImperialSystemCalled, "updateUIToImperialSystem was not called")
    }
    
    /** Given: User enters text in all fields
     *  When:  Pressing "Calculate"
     *  Then:  The next view is displayed with correct remaining daily calories
     */
    func test_didPressCalculateButton() {
        let user = User(preferredUnitOfMeasurement: User.UnitOfMeasurement.imperial, age: 30, gender: User.Gender.male, height: 177, weight: 60, goal: User.Goal.lose, activityLevel: User.ActivityLevel.moderately)
        testObject?.didPressCalculateButton(user: user)
        
        XCTAssertTrue(mockedView!.navigateToCalorieDistributionViewControllerCalled, "navigateToCalorieDistributionViewController was not called")
    }
    
    /** Given: User enters text in all but one field
     *  When:  Pressing "Calculate"
     *  Then:  An Error message is displayed
     */
    func test_didPressCalculateButton_missingInputData() {
        let user = User(preferredUnitOfMeasurement: User.UnitOfMeasurement.imperial, age: 30, gender: User.Gender.male, height: 177, weight: 60, goal: User.Goal.lose, activityLevel: nil)
        testObject?.didPressCalculateButton(user: user)
        
        XCTAssertTrue(mockedView!.showErrorMessageCalled, "showErrorMessage was not called")
    }
    
    /** Given: User enters text in no fields
     *  When:  Pressing "Calculate"
     *  Then:  An Error message is displayed
     */
    func test_didPressCalculateButton_noInputData() {
        let user = User(preferredUnitOfMeasurement: User.UnitOfMeasurement.imperial, age: nil, gender: User.Gender.male, height: nil, weight: nil, goal: User.Goal.lose, activityLevel: nil)
        testObject?.didPressCalculateButton(user: user)
        
        XCTAssertTrue(mockedView!.showErrorMessageCalled, "showErrorMessage was not called")
    }
    
    /** Given: User enters text in all fields
     *  When:  Pressing "Reset"
     *  Then:  All fields should become empty
     */
    func test_didPressResetButton() {
        testObject?.didPressResetButton()
        
        XCTAssertTrue(mockedView!.resetAllFieldsCalled, "resetAllFields was not called")
    }
}

private class PersonalDetailsMock: PersonalDetailsPresentable {
    var resetAllFieldsCalled = false
    var showErrorMessageCalled = false
    var navigateToCalorieDistributionViewControllerCalled = false
    var updateUIToMetricSystemCalled = false
    var updateUIToImperialSystemCalled = false
    
    func resetAllFields() {
        resetAllFieldsCalled = true
    }
    
    func showErrorMessage() {
        showErrorMessageCalled = true
    }
    
    func navigateToCalorieDistributionViewController(user: User) {
        navigateToCalorieDistributionViewControllerCalled = true
    }
    
    func updateUIToMetricSystem() {
        updateUIToMetricSystemCalled = true
    }
    
    func updateUIToImperialSystem() {
        updateUIToImperialSystemCalled = true
    }
}
