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
    func test_1() {
        
    }
    
    /** Given: User selects imperial unit system
     *  When:  -
     *  Then:  height and weight is shown in lb/feet
     */
    func test_2() {
        
    }
    
    /** Given: User enters text in all fields
     *  When:  Pressing "Calculate"
     *  Then:  The next view is displayed with correct remaining daily calories
     */
    func test_3() {
        
    }
    
    /** Given: User enters text in all but one field
     *  When:  Pressing "Calculate"
     *  Then:  An Error message is displayed
     */
    func test_4() {
        
    }
    
    /** Given: User enters text in no fields
     *  When:  Pressing "Calculate"
     *  Then:  An Error message is displayed
     */
    func test_5() {
        
    }
    
    /** Given: User enters text in all fields
     *  When:  Pressing "Reset"
     *  Then:  All fields should become empty
     */
    func test_didPressResetButton() {
        testObject?.didPressResetButton()
        
        XCTAssertTrue(mockedView!.resetAllFieldsCalled, "resetAllFields was never called")
    }
}

private class PersonalDetailsMock: PersonalDetailsPresentable {
    var resetAllFieldsCalled = false
    
    func resetAllFields() {
        resetAllFieldsCalled = true
    }
}
