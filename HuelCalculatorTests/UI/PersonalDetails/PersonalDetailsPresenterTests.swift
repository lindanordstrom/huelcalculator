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

    private var testObject: PersonalDetailsPresenter!
    private var ui: MockedPersonalDetailsUI!
    private var userManager: MockedUserManager!

    override func setUp() {
        super.setUp()
        ui = MockedPersonalDetailsUI()
        userManager = MockedUserManager()
        testObject = PersonalDetailsPresenter(view: ui, userManager: userManager)
    }

    override func tearDown() {
        testObject = nil
        ui = nil
        userManager = nil
        super.tearDown()
    }

    /** Given: No previously saved user exists
     *  When:  The PersonalDetails view is loaded
     *  Then:  All fields are shown empty
     */
    func test_didLoadViewWhenNoSavedUserExists() {
        testObject?.didLoadView()

        XCTAssertTrue(ui.resetAllFieldsCalled)
    }

    /** Given: A saved user exists with preference set to metrics
     *  When:  The PersonalDetails view is loaded
     *  Then:  All fields are populated with the saved users details
     *  And:   The view shown according to the metric system
     */
    func test_didLoadViewWhenMetricUserExists() {
        userManager.user = User(preferredUnitOfMeasurement: .metric, bornYear: "1980", gender: .male, height: 177, weight: 60, goal: .lose, activityLevel: .moderately)
        testObject?.didLoadView()

        XCTAssertTrue(ui.updateUIToMetricSystemCalled)
        XCTAssertTrue(ui.populateFieldsWithUserCalled)
        XCTAssertEqual(ui.user?.height, 177)
    }

    /** Given: A saved user exists with preference set to imperial
     *  When:  The PersonalDetails view is loaded
     *  Then:  All fields are populated with the saved users details
     *  And:   The view shown according to the imperial system
     */
    func test_didLoadViewWhenImperialUserExists() {
        userManager.user = User(preferredUnitOfMeasurement: .imperial, bornYear: "1980", gender: .male, height: 177, weight: 60, goal: .lose, activityLevel: .moderately)
        testObject?.didLoadView()

        XCTAssertTrue(ui.updateUIToImperialSystemCalled)
        XCTAssertTrue(ui.populateFieldsWithUserCalled)
        XCTAssertEqual(ui.user?.height, 177)
    }

    /** Given: User selects metric unit system
     *  When:  -
     *  Then:  The view shown according to the metric system
     */
    func test_didChangeMeasurementValue_metric() {
        testObject?.didChangeMeasurementValue(value: User.UnitOfMeasurement.metric)

        XCTAssertTrue(ui.updateUIToMetricSystemCalled)
    }

    /** Given: User selects imperial unit system
     *  When:  -
     *  Then:  The view shown according to the imperial system
     */
    func test_didChangeMeasurementValue_imperial() {
        testObject?.didChangeMeasurementValue(value: User.UnitOfMeasurement.imperial)

        XCTAssertTrue(ui.updateUIToImperialSystemCalled)
    }

    /** Given: User enters text in all fields
     *  And:   No previous user details exists
     *  When:  Pressing "Done"
     *  Then:  The user is saved
     *  And:   daily calorie consumption is calculated
     *  And:   the personal details view is dismissed
     */
    func test_didPressDoneButton() {
        let user = User(preferredUnitOfMeasurement: .metric, bornYear: "1980", gender: .male, height: 177, weight: 60, goal: .lose, activityLevel: .moderately)

        testObject?.didPressDoneButton(user: user)

        XCTAssertTrue(userManager.saveUserToDataStoreCalled)
        XCTAssertEqual(userManager.user?.height, 177)
        XCTAssertTrue(userManager.saveOldCalorieDistributionsIfNeededCalled)
        XCTAssertEqual(userManager.user?.calorieDistribution.breakfast, nil)
        XCTAssertTrue(userManager.setUsersDailyCalorieConsumptionCalled)
        XCTAssertEqual(ui.showErrorMessageFlag, false)
        XCTAssertTrue(ui.dismissViewControllerCalled)
    }

    /** Given: User enters text in all fields
     *  And:   Previous user details exists
     *  When:  Pressing "Done"
     *  Then:  The user is saved
     *  And:   previous entered calorie distribution is saved to the new user
     *  And:   daily calorie consumption is calculated
     *  And:   the personal details view is dismissed
     */
    func test_didPressDoneButtonWhenPreviousDetailsExists() {
        userManager.user = User(preferredUnitOfMeasurement: .metric, bornYear: "1980", gender: .female, height: 160, weight: 50, goal: .maintain, activityLevel: .very)
        userManager.user?.calorieDistribution = CalorieDistribution(dailyCalorieConsumption: 2000, breakfast: 500, lunch: 500, dinner: 500, snack: 500)

        let user = User(preferredUnitOfMeasurement: .metric, bornYear: "1970", gender: .male, height: 177, weight: 60, goal: .lose, activityLevel: .moderately)

        testObject?.didPressDoneButton(user: user)

        XCTAssertTrue(userManager.saveUserToDataStoreCalled)
        XCTAssertEqual(userManager.user?.height, 177)
        XCTAssertTrue(userManager.saveOldCalorieDistributionsIfNeededCalled)
        XCTAssertEqual(userManager.user?.calorieDistribution.breakfast, 500)
        XCTAssertTrue(userManager.setUsersDailyCalorieConsumptionCalled)
        XCTAssertEqual(ui.showErrorMessageFlag, false)
        XCTAssertTrue(ui.dismissViewControllerCalled)
    }

    /** Given: User enters text in all but one field
     *  When:  Pressing "Done"
     *  Then:  An Error message is displayed
     */
    func test_didPressDoneButton_missingInputData() {
        let user = User(preferredUnitOfMeasurement: .metric, bornYear: "1980", gender: .male, height: nil, weight: 60, goal: .lose, activityLevel: .moderately)
        testObject?.didPressDoneButton(user: user)

        XCTAssertTrue(ui.showErrorMessageCalled)
        XCTAssertEqual(ui.showErrorMessageFlag, true)
    }

    /** Given: User enters text in no fields
     *  When:  Pressing "Done"
     *  Then:  An Error message is displayed
     */
    func test_didPressDoneButton_noInputData() {
        let user = User(preferredUnitOfMeasurement: .metric, bornYear: nil, gender: .male, height: nil, weight: nil, goal: .lose, activityLevel: .moderately)
        testObject?.didPressDoneButton(user: user)

        XCTAssertTrue(ui.showErrorMessageCalled)
        XCTAssertEqual(ui.showErrorMessageFlag, true)
    }

    /** Given: User enters text in all fields
     *  When:  Pressing "Reset"
     *  Then:  All fields should become empty
     */
    func test_didPressResetButton() {
        testObject?.didPressResetButton()

        XCTAssertTrue(ui.resetAllFieldsCalled)
    }
}
