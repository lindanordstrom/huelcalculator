//
//  UserManagerTests.swift
//  HuelCalculatorTests
//
//  Created by Linda on 2018-04-18.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import XCTest
@testable import HuelCalculator

class UserManagerTests: XCTestCase {

    private var testObject: HuelUserManager!
    private var dataStore: MockedDataStore!

    override func setUp() {
        super.setUp()
        dataStore = MockedDataStore()
        testObject = HuelUserManager(dataStore: dataStore)
    }

    override func tearDown() {
        dataStore = nil
        testObject = nil
        super.tearDown()
    }

    /** Given: No previous user have been saved
     *  When:  Asking if signed in user exists
     *  Then:  false should be returned
     */
    func test_signedInUserExistsWhenNoUserExists() {
        let result = testObject.signedInUserExists()

        XCTAssertFalse(result)
        XCTAssertTrue(dataStore.objectForKeyCalled)
    }

    /** Given: A user have been saved
     *  When:  Asking if signed in user exists
     *  Then:  true should be returned
     */
    func test_signedInUserExistsWhenUserExists() {
        let user = User(preferredUnitOfMeasurement: nil, bornYear: nil, gender: nil, height: nil, weight: nil, goal: nil, activityLevel: nil)
        saveUserToMockDataStore(user)

        let result = testObject.signedInUserExists()

        XCTAssertTrue(result)
        XCTAssertTrue(dataStore.objectForKeyCalled)
        XCTAssertEqual(dataStore.key, Constants.Keys.user)
    }

    /** Given: No previous user have been saved
     *  When:  Asking for the signed in user
     *  Then:  no user should be returned
     */
    func test_getSignedInUserWhenNoUserExists() {
        let result = testObject.getSignedInUser()

        XCTAssertNil(result)
        XCTAssertTrue(dataStore.objectForKeyCalled)
        XCTAssertEqual(dataStore.key, Constants.Keys.user)
    }

    /** Given: A user have been saved
     *  When:  Asking for the signed in user
     *  Then:  the user should be returned
     */
    func test_getSignedInUserWhenUserExists() {
        let user = User(preferredUnitOfMeasurement: nil, bornYear: "1980", gender: nil, height: nil, weight: nil, goal: nil, activityLevel: nil)
        saveUserToMockDataStore(user)

        let result = testObject.getSignedInUser()

        XCTAssertEqual(result?.age, 38)
        XCTAssertTrue(dataStore.objectForKeyCalled)
        XCTAssertEqual(dataStore.key, Constants.Keys.user)
    }

    /** Given:
     *  When:  Asking to save a user to the data store
     *  Then:  the user should be saved
     */
    func test_saveUserToDataStore() {
        let user = User(preferredUnitOfMeasurement: nil, bornYear: "1980", gender: nil, height: nil, weight: nil, goal: nil, activityLevel: nil)

        testObject.saveUserToDataStore(user: user)

        XCTAssertTrue(dataStore.setValueForeKeyCalled)
        XCTAssertEqual(getUserFromMockDataStore()?.age, 38)
        XCTAssertEqual(dataStore.key, Constants.Keys.user)
    }

    /** Given:
     *  When:  Asking to save nil to the data store
     *  Then:  Nothing should be saved to the datastore
     */
    func test_saveNilToDataStore() {
        testObject.saveUserToDataStore(user: nil)

        XCTAssertFalse(dataStore.setValueForeKeyCalled)
        XCTAssertNil(dataStore.value)
        XCTAssertNil(dataStore.key)
    }

    /** Given: A previous user with calorie distribution exists
     *  When:  Asking to save previous distributions to the new user if needed
     *  Then:  The new user should be updated with the old users distribution
     */
    func test_saveOldCalorieDistributionsIfNeeded() {
        let oldUser = User(preferredUnitOfMeasurement: nil, bornYear: "1980", gender: .male, height: nil, weight: nil, goal: nil, activityLevel: nil)
        oldUser.calorieDistribution = CalorieDistribution(dailyCalorieConsumption: 2000, breakfast: 500, lunch: 400, dinner: 300, snack: 200)
        saveUserToMockDataStore(oldUser)

        var newUser: User? = User(preferredUnitOfMeasurement: nil, bornYear: "1980", gender: .female, height: nil, weight: nil, goal: nil, activityLevel: nil)

        testObject.saveOldCalorieDistributionsIfNeeded(user: &newUser)

        XCTAssertTrue(dataStore.objectForKeyCalled)
        XCTAssertEqual(newUser?.calorieDistribution.breakfast, 500)
        XCTAssertEqual(newUser?.calorieDistribution.lunch, 400)
        XCTAssertEqual(newUser?.calorieDistribution.dinner, 300)
        XCTAssertEqual(newUser?.calorieDistribution.snack, 200)
        XCTAssertEqual(newUser?.gender, .female)
    }

    /** Given: No previous user exists
     *  When:  Asking to save previous distributions to the new user if needed
     *  Then:  Nothing should be updated on the new user
     */
    func test_saveOldCalorieDistributionsIfNeededWhenNoPreviousUserExists() {
        var newUser: User? = User(preferredUnitOfMeasurement: nil, bornYear: "1980", gender: .female, height: nil, weight: nil, goal: nil, activityLevel: nil)

        testObject.saveOldCalorieDistributionsIfNeeded(user: &newUser)

        XCTAssertTrue(dataStore.objectForKeyCalled)
        XCTAssertEqual(newUser?.calorieDistribution.breakfast, nil)
        XCTAssertEqual(newUser?.calorieDistribution.lunch, nil)
        XCTAssertEqual(newUser?.calorieDistribution.dinner, nil)
        XCTAssertEqual(newUser?.calorieDistribution.snack, nil)
        XCTAssertEqual(newUser?.gender, .female)
    }

    /** Given: A user have been saved
     *  When:  Distributing calories
     *  Then:  The user should be updated with correct calorie distribution
     */
    func test_distributeCalories() {
        let user = User(preferredUnitOfMeasurement: nil, bornYear: "1980", gender: .male, height: nil, weight: nil, goal: nil, activityLevel: nil)
        user.calorieDistribution = CalorieDistribution(dailyCalorieConsumption: 2000, breakfast: nil, lunch: nil, dinner: nil, snack: nil)
        saveUserToMockDataStore(user)

        testObject.distributeCalories(breakfast: 500, lunch: 400, dinner: 300, snack: 200)

        XCTAssertTrue(dataStore.objectForKeyCalled)
        XCTAssertTrue(dataStore.setValueForeKeyCalled)

        let updatedUser = getUserFromMockDataStore()

        XCTAssertEqual(updatedUser?.calorieDistribution.breakfast, 500)
        XCTAssertEqual(updatedUser?.calorieDistribution.lunch, 400)
        XCTAssertEqual(updatedUser?.calorieDistribution.dinner, 300)
        XCTAssertEqual(updatedUser?.calorieDistribution.snack, 200)
    }

    /** Given: A user have been saved
     *  When:  Setting the users daily consumption
     *  Then:  The user should be updated with correct daily consumtion
     */
    func test_setUsersDailyCalorieConsumption() {
        saveUserToMockDataStore(User(preferredUnitOfMeasurement: .metric, bornYear: "1980", gender: .male, height: 180, weight: 70, goal: .maintain, activityLevel: .moderately))
        testObject.setUsersDailyCalorieConsumption()
        XCTAssertTrue(dataStore.objectForKeyCalled)
        XCTAssertTrue(dataStore.setValueForeKeyCalled)
        XCTAssertEqual(getUserFromMockDataStore()?.calorieDistribution.dailyCalorieConsumption, 2542)

        saveUserToMockDataStore(User(preferredUnitOfMeasurement: .metric, bornYear: "1980", gender: .female, height: 180, weight: 70, goal: .lose, activityLevel: .very))
        testObject.setUsersDailyCalorieConsumption()
        XCTAssertEqual(getUserFromMockDataStore()?.calorieDistribution.dailyCalorieConsumption, 2042)

        saveUserToMockDataStore(User(preferredUnitOfMeasurement: .metric, bornYear: "1980", gender: .male, height: 180, weight: 70, goal: .gain, activityLevel: .lightly))
        testObject.setUsersDailyCalorieConsumption()
        XCTAssertEqual(getUserFromMockDataStore()?.calorieDistribution.dailyCalorieConsumption, 2755)

        saveUserToMockDataStore(User(preferredUnitOfMeasurement: .metric, bornYear: "1980", gender: .male, height: 180, weight: 70, goal: .maintain, activityLevel: .sedentary))
        testObject.setUsersDailyCalorieConsumption()
        XCTAssertEqual(getUserFromMockDataStore()?.calorieDistribution.dailyCalorieConsumption, 1968)

        saveUserToMockDataStore(User(preferredUnitOfMeasurement: .imperial, bornYear: "1980", gender: .male, height: 6, weight: 154, goal: .maintain, activityLevel: .extra))
        testObject.setUsersDailyCalorieConsumption()
        XCTAssertEqual(getUserFromMockDataStore()?.calorieDistribution.dailyCalorieConsumption, 3147)
    }

    /** Given: A user have been saved but does not contain all the nessecary values
     *  When:  Setting the users daily consumption
     *  Then:  The user should not be updated
     */
    func test_setUsersDailyCalorieConsumptionWhenValuesAreMissing() {
        saveUserToMockDataStore(User(preferredUnitOfMeasurement: .metric, bornYear: "1980", gender: .male, height: nil, weight: 70, goal: .maintain, activityLevel: .moderately))

        testObject.setUsersDailyCalorieConsumption()

        XCTAssertTrue(dataStore.objectForKeyCalled)
        XCTAssertFalse(dataStore.setValueForeKeyCalled)

        XCTAssertEqual(getUserFromMockDataStore()?.calorieDistribution.dailyCalorieConsumption, nil)
    }

    private func saveUserToMockDataStore(_ user: User) {
        dataStore.value = try? JSONEncoder().encode(user)
    }

    private func getUserFromMockDataStore() -> User? {
        return try? JSONDecoder().decode(User.self, from: dataStore.value as! Data)
    }
}
