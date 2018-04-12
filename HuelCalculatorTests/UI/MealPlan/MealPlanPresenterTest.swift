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
    
    private var testUrlHandler: TestUrlHandler?
    private var testObject: MealPlanPresenter?
    private var mockedView: MealPlanMock?
    private var user: User?
    
    override func setUp() {
        super.setUp()
        testUrlHandler = TestUrlHandler()
        testObject = MealPlanPresenter(urlHandler: testUrlHandler!)
        mockedView = MealPlanMock()
        user = User(preferredUnitOfMeasurement: nil, age: nil, gender: nil, height: nil, weight: nil, goal: nil, activityLevel: nil, flavour: nil)
        user?.calorieDistribution.breakfast = 100
        user?.calorieDistribution.lunch = 200
        user?.calorieDistribution.dinner = 300
        user?.calorieDistribution.snack = 400
        testObject?.set(view: mockedView!)
    }

    override func tearDown() {
        testUrlHandler = nil
        testObject = nil
        user = nil
        super.tearDown()
    }
    
    /** Given: User has distributed calories
     *  When:  Page is loaded and flavour system is "unflavoured"
     *  Then:  The calories will be calculated to scoops/grams of unflavoured HUEL
     */
    func test_didLoadView_unflavoured() {
        user?.flavour = .unflavoured
        XCTAssert(mockedView?.breakfastAmount == "24 g / 0.6 scoops")
        XCTAssert(mockedView?.lunchAmount == "48 g / 1.3 scoops")
        XCTAssert(mockedView?.dinnerAmount == "73 g / 1.9 scoops")
        XCTAssert(mockedView?.snackAmount == "97 g / 2.5 scoops")
    }
    
    /** Given: User has distributed calories
     *  When:  Page is loaded and flavour system is "vanilla"
     *  Then:  The calories will be calculated to scoops/grams of vanilla HUEL
     */
    func test_didLoadView_vanilla() {
        user?.flavour = .vanilla
        testObject?.didLoadView(user: user)
        XCTAssert(mockedView?.breakfastAmount == "25 g / 0.7 scoops")
        XCTAssert(mockedView?.lunchAmount == "50 g / 1.3 scoops")
        XCTAssert(mockedView?.dinnerAmount == "75 g / 2.0 scoops")
        XCTAssert(mockedView?.snackAmount == "100 g / 2.6 scoops")
    }

    /** Given: "Get Huel" button is pressed
     *  When:  -
     *  Then:  The "open" function gets called with the expected URL
     */
    func test_didPressGetHuel() {
        let expectedUrl = "https://huel.com/products/huel"
        testObject!.didPressGetHuel()
        
        XCTAssert(testUrlHandler?.urlStringVisited == expectedUrl, "Expected link was not used!")
    }
}

private class TestUrlHandler: UrlHandler {
    var urlStringVisited: String?
    
    func openURL(_ url: URL) -> Bool {
        urlStringVisited = url.absoluteString
        return true
    }
    
}

private class MealPlanMock: MealPlanPresentable {
    var breakfastAmount: String?
    var lunchAmount: String?
    var dinnerAmount: String?
    var snackAmount: String?
    
    func setBreakfastAmount(amountLabel: String?) {
        breakfastAmount = amountLabel
    }
    
    func setLunchAmount(amountLabel: String?) {
        lunchAmount = amountLabel
    }
    
    func setDinnerAmount(amountLabel: String?) {
        dinnerAmount = amountLabel
    }
    
    func setSnackAmount(amountLabel: String?) {
        snackAmount = amountLabel
    }
}
