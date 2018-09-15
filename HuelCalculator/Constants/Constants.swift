//
//  Constants.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import Foundation

enum menuItem: String {
    case vanillaShake = "Vanilla"
    case unflavouredShake = "Unflavoured"
    case bar = "Bar"
    case shop = "Buy Huel"
    case appFeedback = "App Feedback"
}

struct Constants {
    struct LandingPage {
        static let cellIdentifier = "Cell"
        static let noProfileAlertTitle = "No profile added"
        static let noProfileAlertMessage = "You need to enter your personal details to be able to calculate your daily needs"
        static let getHuelUrl = "https://huel.com/products/huel"
    }
    struct AppFeedbackPage {
        static let viewControllerName = "AppFeedbackViewController"
        static let appStoreUrl = "itms-apps://itunes.apple.com/app/id1188836017"
        static let emailRecipient = "huelcalculator@gmail.com"
        static let emailSubject = "Feedback: Huel Calculator"
        static let emailMessage = "<br><i>Enter your feedback here</i><br><br>-----------------------<br>App version: %@<br>Device: %@<br>iOS version: %@<br>-----------------------<br>"
        static let couldNotOpenEmailAlertTitle = "Could not open your email client"
        static let couldNotOpenEmailAlertMessage = "There was a problem opening your email client, please send your message manually to huelcalculator@gmail.com"
        static let appVersionKey = "CFBundleShortVersionString"
    }
    struct PersonalDetailsPage {
        static let segueToThisPageName = "showPersonalDetailsPage"
        static let inches = "inches"
        static let pounds = "pounds"
        static let kg = "kg"
        static let cm = "cm"
        static let halfKg = "0.5 kg"
        static let onePound = "1 lb"
        static let pickerViewController = "PickerViewController"
    }
    struct CalorieDistributionPage {
        static let viewControllerName = "CalorieDistributionViewController"
        static let remainingCaloriesAlertMessagePart1 = "Your remaining calories are "
        static let remainingCaloriesAlertMessagePart2 = ", are you sure you want to continue?"
    }
    struct MealPlanPage {
        static let segueToThisPageName = "showMealPlanPage"
        static let numberOfBarsGramsAndKcal = "%.1f bars / %.0f g\nTotal: %d kcal"
        static let numberOfGramsScoopsAndKcal = "%.0f g / %.1f scoops\n%.0f ml water\nTotal: %d kcal"
    }

    struct User {
        static let sedentaryActive = "Sedentary - little or no exercise"
        static let lightlyActive =  "Lightly Active - exercise 1-3 times/week"
        static let moderatelyActive =  "Moderately Active - exercise 3-5 times/week"
        static let veryActive =  "Very Active - hard exercise 6-7 times/week"
        static let extraActive =  "Extra Active - very hard exercise or physical job"
        static let selectActivity =  "Select activity"
    }

    struct Keys {
        static let user = "user"
    }

    struct General {
        static let storyboardMain = "Main"
        static let warningAlertTitle = "Warning"
        static let okButtonText = "OK"
        static let cancelButtonText = "Cancel"
        static let yesButtonText = "Yes"
        static let noButtonText = "No"
        static let emptyString = ""
        static let zeroString = "0"
    }
}
