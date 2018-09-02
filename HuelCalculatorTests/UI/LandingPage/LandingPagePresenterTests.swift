//
//  LandingPagePresenterTests.swift
//  HuelCalculatorTests
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import XCTest
@testable import HuelCalculator

class LandingPagePresenterTests: XCTestCase {

    private var testObject: LandingPagePresenter!
    private var ui: MockedLandingPageUI!
    private var urlHandler: MockedUrlHandler!
    private var userManager: MockedUserManager!

    override func setUp() {
        super.setUp()
        ui = MockedLandingPageUI()
        urlHandler = MockedUrlHandler()
        userManager = MockedUserManager()
        testObject = LandingPagePresenter(view: ui, urlManager: UrlManager(urlHandler: urlHandler), userManager: userManager)
    }

    override func tearDown() {
        ui = nil
        urlHandler = nil
        testObject = nil
        userManager = nil
        super.tearDown()
    }

    /** Given:
     *  When: Number of menu items is requested
     *  Then: The correct number is returned
     */
    func test_didPressRateTheApp() {
        let numberOfMenuItems = testObject.numberOfItemsOnLandingPage()

        XCTAssertEqual(numberOfMenuItems, 5)
    }

    /** Given: A user already exists
     *  When: Requested to show personal details page if needed
     *  Then: Nothing should happen
     */
    func test_showPersonalDetailsPageIfNeededWhenUserAlreadyExists() {
        userManager.user = User(preferredUnitOfMeasurement: .metric, bornYear: "1980", gender: .male, height: 177, weight: 60, goal: .lose, activityLevel: .moderately)

        testObject.showPersonalDetailsPageIfNeeded()

        XCTAssertFalse(ui.showErrorAndPersonalDetailsPageCalled)
    }

    /** Given: No user exists
     *  When: Requested to show personal details page if needed
     *  Then: The UI should show an error and the personal details page
     */
    func test_showPersonalDetailsPageIfNeededWhenNoUserExists() {
        testObject.showPersonalDetailsPageIfNeeded()

        XCTAssertTrue(ui.showErrorAndPersonalDetailsPageCalled)
    }


    /** Given:
     *  When: Going through the different menu items
     *  Then: The correct image and title should be returned
     */
    func test_getTitleAndImageFromIndexPath() {
        var result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 0, section: 0))
        XCTAssertEqual(result.title, "Unflavoured")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_shake"))

        result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 1, section: 0))
        XCTAssertEqual(result.title, "Vanilla")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_shake"))

        result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 2, section: 0))
        XCTAssertEqual(result.title, "Bar")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_bar"))

        result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 3, section: 0))
        XCTAssertEqual(result.title, "Buy Huel")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_shop"))

        result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 4, section: 0))
        XCTAssertEqual(result.title, "App Feedback")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_feedack"))
    }


    /** Given:
     *  When: Selecting the different menu items
     *  Then: The correct view should load
     */
    func test_didSelectItemOnLandingPage() {
        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 0, section: 0))
        XCTAssertTrue(ui.showCalculationPageCalled)
        XCTAssertEqual(ui.product?.kcalPer100gram, HuelUnflavouredShake().kcalPer100gram)

        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 1, section: 0))
        XCTAssertTrue(ui.showCalculationPageCalled)
        XCTAssertEqual(ui.product?.kcalPer100gram, HuelVanillaShake().kcalPer100gram)

        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 2, section: 0))
        XCTAssertTrue(ui.showCalculationPageCalled)
        XCTAssertEqual(ui.product?.kcalPer100gram, HuelBar().kcalPer100gram)

        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 3, section: 0))
        XCTAssertTrue(urlHandler.openURLCalled)
        XCTAssertEqual(urlHandler.urlString, "https://huel.com/products/huel")

        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 4, section: 0))
        XCTAssertTrue(ui.showAppFeedbackCalled)
    }
}

