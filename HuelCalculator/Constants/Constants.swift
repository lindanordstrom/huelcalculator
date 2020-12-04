//
//  Constants.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

// swiftlint:disable line_length

enum MenuItem: String {
    case huelShake = "Huel Shake v.3.0 (any flavour)"
    case huelBlackShake = "Huel Black Edition v.1.0 (any flavour)"
    case huelReadyToDrink = "Huel Ready-to-drink v.1.0 (any flavour)"
    case huelHotAndSavoury = "Huel Hot & Savoury v.1.0 (any flavour)"
    case bar = "Huel Bar v.3.1 (any flavour)"
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
        static let kilo = "kg"
        static let centimeter = "cm"
        static let halfKilo = "0.5 kg"
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
        static let numberOfGramsScoopsAndKcalHotAndSavoury = "%.0f g / %.1f scoops\n%.0fml of boiling water\nTotal: %d kcal"
        static let numberOfRtDBottlesMlAndKcal = "%.1f Ready-to-drink bottles / %.0f ml\nTotal: %d kcal"
    }

    struct User {
        static let sedentaryActive = "Little or no exercise"
        static let lightlyActive =  "Exercise 1-3 times/week"
        static let moderatelyActive =  "Exercise 3-5 times/week"
        static let veryActive =  "Exercise 6-7 times/week"
        static let extraActive =  "Hard daily exercise/physical job"
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
