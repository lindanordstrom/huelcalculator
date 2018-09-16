//
//  CalorieDistributionPresenter.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

class CalorieDistributionPresenter {
    
    private weak var view: CalorieDistributionUI?
    private var userManager: UserManager
    
    init(view: CalorieDistributionUI, userManager: UserManager = HuelUserManager.shared) {
        self.view = view
        self.userManager = userManager
    }
    
    func shouldShowMealPlanPage(remainingCalories: Int?) -> Bool {
        guard let remainingCalories = remainingCalories else {
            return false
        }
        guard remainingCalories == 0 else {
            view?.showPopupWarning(remainingCalories: remainingCalories)
            return false
        }

        return true
    }
    
    func didPressSplitEquallyButton() {
        let user = userManager.getSignedInUser()
        guard let calories = user?.calorieDistribution.dailyCalorieConsumption else {
            return
        }
        let quarter = calories / 4
        let dinner = calories - quarter * 3

        updateUserConsumption(breakfast: quarter, lunch: quarter, dinner: dinner, snack: quarter)
        updateInputFields()
    }
    
    func updateUserConsumption(breakfast: Int, lunch: Int, dinner: Int, snack: Int) {
        userManager.distributeCalories(breakfast: breakfast, lunch: lunch, dinner: dinner, snack: snack)
    }

    func updateInputFields() {
        let user = userManager.getSignedInUser()
        let dailyConsumption = user?.calorieDistribution.dailyCalorieConsumption ?? 0
        let breakfast = user?.calorieDistribution.breakfast ?? 0
        let lunch = user?.calorieDistribution.lunch ?? 0
        let dinner = user?.calorieDistribution.dinner ?? 0
        let snack = user?.calorieDistribution.snack ?? 0

        let usedCalories = breakfast + lunch + dinner + snack

        if dailyConsumption < usedCalories {
            view?.setRemainingCaloriesLabelRed()
        } else {
            view?.setRemainingCaloriesLabelBlack()
        }

        view?.setBreakfastCaloriesInputField(calories: breakfast)
        view?.setLunchCaloriesInputField(calories: lunch)
        view?.setDinnerCaloriesInputField(calories: dinner)
        view?.setSnackCaloriesInputField(calories: snack)
        view?.setRemainingCaloriesLabel(calories: dailyConsumption - usedCalories)
    }
}
