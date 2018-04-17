//
//  AppFeedbackPresenterTests.swift
//  HuelCalculatorTests
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import XCTest
@testable import HuelCalculator

class AppFeedbackPresenterTests: XCTestCase {

    private var testObject: AppFeedbackPresenter!
    private var ui: MockedAppFeedbackUI!
    private var deviceInfo: MockedDeviceInfo!
    private var urlHandler: MockedUrlHandler!

    override func setUp() {
        super.setUp()
        ui = MockedAppFeedbackUI()
        deviceInfo = MockedDeviceInfo()
        urlHandler = MockedUrlHandler()
        testObject = AppFeedbackPresenter(view: ui, device: deviceInfo, urlManager: UrlManager(urlHandler: urlHandler))
    }
    
    override func tearDown() {
        ui = nil
        deviceInfo = nil
        urlHandler = nil
        testObject = nil
        super.tearDown()
    }

    /** Given:
     *  When: "Rate the app" button is pressed
     *  Then: The "open" function gets called with the expected URL
     */
    func test_didPressRateTheApp() {
        let expectedString = "itms-apps://itunes.apple.com/app/id1188836017"
        testObject?.didPressRateTheApp()

        XCTAssertTrue(urlHandler.openURLCalled)
        XCTAssertEqual(urlHandler.urlString, expectedString)
    }

    /** Given: The device cannot open the mail client
     *  When:  "Send email" button is pressed
     *  Then:  An error message is displayed
     */
    func test_didPressSendEmailWhenDeviceIsUnableToOpenMailClient() {
        testObject?.didPressSendEmailButton(canSendMail: false)

        XCTAssertTrue(ui.showMailErrorCalled)
    }

    /** Given: The device can open the mail client
     *  When:  "Send email" button is pressed
     *  Then:  The ui should launch the mail client with prefilled content
     */
    func test_didPressSendEmail() {
        testObject?.didPressSendEmailButton(canSendMail: true)

        XCTAssertTrue(ui.showMailComposeViewCalled)
        XCTAssertEqual(ui.mail.recipients.first, "lindanordstrom86@gmail.com")
        XCTAssertEqual(ui.mail.subject, "Feedback: Huel Calculator")
        XCTAssertEqual(ui.mail.message, "<br><i>Enter your feedback here</i><br><br>-----------------------<br>App version: 1.0.1<br>Device: mockedModelName<br>iOS version: mockedSystemVersion<br>-----------------------<br>")
    }
}
