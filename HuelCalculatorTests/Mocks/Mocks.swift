//
//  Mocks.swift
//  HuelCalculatorTests
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import Foundation
@testable import HuelCalculator

class MockedLandingPageUI: LandingPageUI {
    var showCalculationPageCalled = false
    var showAppFeedbackCalled = false
    var showErrorAndPersonalDetailsPageCalled = false
    var product: MealReplacementProduct?

    func showCalculationPage(with product: MealReplacementProduct) {
        showCalculationPageCalled = true
        self.product = product
    }
    func showAppFeedback() {
        showAppFeedbackCalled = true
    }
    func showErrorAndPersonalDetailsPage() {
        showErrorAndPersonalDetailsPageCalled = true
    }
}

class MockedAppFeedbackUI: AppFeedbackUI {
    var showMailComposeViewCalled = false
    var showMailErrorCalled = false
    var mail = (recipients: [""], subject: "", message: "")

    func showMailComposeView(recipients: [String]?, subject: String, message: String) {
        showMailComposeViewCalled = true
        mail.recipients = recipients ?? [""]
        mail.subject = subject
        mail.message = message
    }
    func showMailError() {
        showMailErrorCalled = true
    }
}

class MockedPersonalDetailsUI: PersonalDetailsUI {
    var resetAllFieldsCalled = false
    var showErrorMessageCalled = false
    var populateFieldsWithUserCalled = false
    var updateUIToMetricSystemCalled = false
    var updateUIToImperialSystemCalled = false
    var dismissViewControllerCalled = false
    var user: User?
    var showErrorMessageFlag: Bool?

    func resetAllFields() {
        resetAllFieldsCalled = true
    }

    func showErrorMessage(_ flag: Bool) {
        showErrorMessageCalled = true
        showErrorMessageFlag = flag
    }

    func populateFieldsWith(user: User) {
        self.user = user
        populateFieldsWithUserCalled = true
    }

    func updateUIToMetricSystem() {
        updateUIToMetricSystemCalled = true
    }

    func updateUIToImperialSystem() {
        updateUIToImperialSystemCalled = true
    }

    func dismissViewController() {
        dismissViewControllerCalled = true
    }
}

class MockedMealPlanUI: MealPlanUI {
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

class MockedUserManager: UserManager {
    var signedInUserExistsCalled = false
    var getSignedInUserCalled = false
    var saveUserToDataStoreCalled = false
    var saveOldCalorieDistributionsIfNeededCalled = false
    var distributeCaloriesCalled = false
    var setUsersDailyCalorieConsumptionCalled = false
    var user: User?
    var calorieDistribution: CalorieDistribution?

    func signedInUserExists() -> Bool {
        signedInUserExistsCalled = true
        return user != nil
    }
    func getSignedInUser() -> User? {
        getSignedInUserCalled = true
        return user
    }
    func saveUserToDataStore(user: User?) {
        saveUserToDataStoreCalled = true
        self.user = user
    }
    func saveOldCalorieDistributionsIfNeeded(user: inout User?) {
        user?.calorieDistribution = self.user?.calorieDistribution ?? CalorieDistribution()
        saveOldCalorieDistributionsIfNeededCalled = true
    }
    func distributeCalories(breakfast: Int, lunch: Int, dinner: Int, snack: Int) {
        distributeCaloriesCalled = true
        calorieDistribution = CalorieDistribution(dailyCalorieConsumption: nil, breakfast: breakfast, lunch: lunch, dinner: dinner, snack: snack)
    }
    func setUsersDailyCalorieConsumption() {
        setUsersDailyCalorieConsumptionCalled = true
    }
}

class MockedDeviceInfo: DeviceInfo {
    var systemVersion: String {
        get {
            return "mockedSystemVersion"
        }
    }
    var modelName: String {
        get {
            return "mockedModelName"
        }
    }
}

class MockedUrlHandler: UrlHandler {
    var openURLCalled = false
    var urlString: String?

    func openURL(_ url: URL) -> Bool {
        openURLCalled = true
        urlString = url.absoluteString
        return true
    }
    @available(iOS 10.0, *)
    func open(_ url: URL, options: [String : Any], completionHandler completion: ((Bool) -> Swift.Void)?) {
        openURLCalled = true
        urlString = url.absoluteString
    }
}
