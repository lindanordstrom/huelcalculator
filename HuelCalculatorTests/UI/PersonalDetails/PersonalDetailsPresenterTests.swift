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
    
    override func setUp() {
        super.setUp()
        testObject = PersonalDetailsPresenter()
    }
    
    override func tearDown() {
        testObject = nil
        super.tearDown()
    }
    
    /** Given: User selects metric unit system
     *  When:  -
     *  Then:  height and weight is shown in kg/cm
     */
    func test_() {
        
    }
    
    /** Given: User selects imperial unit system
     *  When:  -
     *  Then:  height and weight is shown in lb/feet
     */
    func test_() {
        
    }
    
    /** Given: User enters all fields
     *  When:  Pressing "Calculate"
     *  Then:  The next view is displayed with correct remaining daily calories
     */
    func test_() {
        
    }
    
    /** Given: User enters all but one field
     *  When:  Pressing "Calculate"
     *  Then:  An Error message is displayed
     */
    func test_() {
        
    }
    
    /** Given: User enters no fields
     *  When:  Pressing "Calculate"
     *  Then:  An Error message is displayed
     */
    func test_() {
        
    }
    
    // RESET BUTTON
}
