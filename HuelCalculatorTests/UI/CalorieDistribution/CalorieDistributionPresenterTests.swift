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
    
    override func setUp() {
        super.setUp()
        testObject = CalorieDistributionPresenter()
    }
    
    override func tearDown() {
        testObject = nil
        super.tearDown()
    }
    
    /** Given: User enters a number in any field
     *  When:  The focus leaves the input field
     *  Then:  The remaining calories decreases with the same amount
     */
    func test_() {
        
    }
    
    /** Given: User enters a number larger than the remaining calories in any field
     *  When:  The focus leaves the input field
     *  Then:  The remaining calories decreases with the same amount and the negative amount will be displayed in red
     */
    func test_1() {
        
    }
    
    /** Given: User presses the "split equally" button
     *  When:  -
     *  Then:  The remaining calories will be split equally into the fields with the "remainder" calories added to Dinner
     */
    func test_2() {
        
    }
    
    /** Given: User presses the "next" button
     *  When:  Remaining calories is 0
     *  Then:  The next view is displayed
     */
    func test_4() {
        
    }
    
    /** Given: User presses the "next" button
     *  When:  Remaining calories is more or less than 0
     *  Then:  The a warning popup is displayed
     */
    func test_5() {
        
    }
}
