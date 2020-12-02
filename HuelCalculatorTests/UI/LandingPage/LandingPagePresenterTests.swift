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
    private let infoPopupKey = "TestInfoPopupKeyShown"

    override func setUp() {
        super.setUp()
        ui = MockedLandingPageUI()
        urlHandler = MockedUrlHandler()
        userManager = MockedUserManager()
        testObject = LandingPagePresenter(view: ui, urlManager: UrlManager(urlHandler: urlHandler), userManager: userManager, infoPopupKey: infoPopupKey)
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

        XCTAssertEqual(numberOfMenuItems, 7)
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
    
    /** Given: Info popup has not been shown
     *  When: Requested to show info popup if needed
     *  Then: The UI should show an info popup
     */
    func test_showInfoPopupIfNeededWhenNotShownBefore() {
        UserDefaults.standard.set(false, forKey: infoPopupKey)
        
        testObject.showInfoPopupAlertIfNeeded()
        
        XCTAssertTrue(ui.showInfoPopupAlertCalled)
    }
    
    /** Given: Info popup has been shown before
     *  When: Requested to show info popup if needed
     *  Then: The UI should not show an info popup
     */
    func test_showInfoPopupIfNeededWhenShownBefore() {
        UserDefaults.standard.set(true, forKey: infoPopupKey)
        
        testObject.showInfoPopupAlertIfNeeded()
        
        XCTAssertFalse(ui.showInfoPopupAlertCalled)
    }

    /** Given:
     *  When: Going through the different menu items
     *  Then: The correct image and title should be returned
     */
    func test_getTitleAndImageFromIndexPath() {
        var result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 0, section: 0))
        XCTAssertEqual(result.title, "Huel Shake v.3.0 (any flavour)")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_shake"))

        result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 1, section: 0))
        XCTAssertEqual(result.title, "Huel Black Edition v.1.0 (any flavour)")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_shake_black"))

        result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 2, section: 0))
        XCTAssertEqual(result.title, "Huel Ready-to-drink v.1.0 (any flavour)")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_readytodrink"))
        
        result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 3, section: 0))
        XCTAssertEqual(result.title, "Huel Hot & Savoury v.1.0 (any flavour)")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_granola"))
        
        result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 4, section: 0))
        XCTAssertEqual(result.title, "Huel Bar v.3.1 (any flavour)")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_bar"))

        result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 5, section: 0))
        XCTAssertEqual(result.title, "Buy Huel")
        XCTAssertEqual(result.image, #imageLiteral(resourceName: "menu_shop"))

        result = testObject.getTitleAndImageFrom(indexPath: IndexPath(item: 6, section: 0))
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
        XCTAssertEqual(ui.product?.kcalPer100gram, HuelShake().kcalPer100gram)

        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 1, section: 0))
        XCTAssertTrue(ui.showCalculationPageCalled)
        XCTAssertEqual(ui.product?.kcalPer100gram, HuelBlackEditionShake().kcalPer100gram)

        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 2, section: 0))
        XCTAssertTrue(ui.showCalculationPageCalled)
        XCTAssertEqual(ui.product?.kcalPer100gram, HuelReadyToDrink().kcalPer100gram)
        
        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 3, section: 0))
        XCTAssertTrue(ui.showCalculationPageCalled)
        XCTAssertEqual(ui.product?.kcalPer100gram, HuelHotAndSavoury().kcalPer100gram)
        
        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 4, section: 0))
        XCTAssertTrue(ui.showCalculationPageCalled)
        XCTAssertEqual(ui.product?.kcalPer100gram, HuelBar().kcalPer100gram)

        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 5, section: 0))
        XCTAssertTrue(urlHandler.openURLCalled)
        XCTAssertEqual(urlHandler.urlString, "https://huel.com/products/huel")

        testObject.didSelectItemOnLandingPage(indexPath: IndexPath(item: 6, section: 0))
        XCTAssertTrue(ui.showAppFeedbackCalled)
    }
}
