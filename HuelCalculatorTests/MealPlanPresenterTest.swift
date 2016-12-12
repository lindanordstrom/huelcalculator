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
    
    /**
     *
     */
    func testGetHuel() {
        let expectedUrl = "http://www.huel.com"
        testObject!.didPressGetHuel()
        
        XCTAssert(testUrlHandler?.urlStringVisited == "abc", "Expected link was not used!")
    }
}

private class TestUrlHandler: UrlHandler {
    var urlStringVisited: String?
    
    func open(_ url: URL, options: [String : Any], completionHandler: ((Bool) -> Void)?) {
        urlStringVisited = url.absoluteString
    }
    
}
