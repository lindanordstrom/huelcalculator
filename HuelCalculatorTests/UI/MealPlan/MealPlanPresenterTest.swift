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
    
    override func setUp() {
        super.setUp()
        testUrlHandler = TestUrlHandler()
        testObject = MealPlanPresenter(urlHandler: testUrlHandler!)
    }

    override func tearDown() {
        testUrlHandler = nil
        testObject = nil
        super.tearDown()
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
    
    /** Given:
     *  When:
     *  Then:
     */
    func test_() {
        
    }
}

private class TestUrlHandler: UrlHandler {
    var urlStringVisited: String?
    
    func open(_ url: URL, options: [String : Any], completionHandler: ((Bool) -> Void)?) {
        urlStringVisited = url.absoluteString
    }
    
}
