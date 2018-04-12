//
//  CalorieDistributionPresenter.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import Foundation

protocol CalorieDistributionPresentable: class {
    func navigateToMealPlanViewController()
    func setRemainingCaloriesLabel(calories: Int)
    func setBreakfastCaloriesInputField(calories: Int)
    func setLunchCaloriesInputField(calories: Int)
    func setDinnerCaloriesInputField(calories: Int)
    func setSnackCaloriesInputField(calories: Int)
    func setRemainingCaloriesLabelRed()
    func setRemainingCaloriesLabelBlack()
    func showPopupWarning(remainingCalories: Int)
}

class CalorieDistributionPresenter {
    
    private weak var view: CalorieDistributionPresentable?
    
    func set(view: CalorieDistributionPresentable) {
        self.view = view
    }
    
    func didPressNextButton(remainingCalories: String?) {
        guard let remainingCaloriesString = remainingCalories,
            let remainingCalories = Int(remainingCaloriesString) else {
                return
        }
        guard remainingCalories == 0 else {
            view?.showPopupWarning(remainingCalories: remainingCalories)
            return
        }
        view?.navigateToMealPlanViewController()
    }
    
    func didPressSplitEquallyButton(calories: Int?) {
        guard let calories = calories else {
            return
        }
        let quarter = calories / 4
        let dinner = calories - quarter * 3
        view?.setBreakfastCaloriesInputField(calories: quarter)
        view?.setLunchCaloriesInputField(calories: quarter)
        view?.setDinnerCaloriesInputField(calories: dinner)
        view?.setSnackCaloriesInputField(calories: quarter)
        view?.setRemainingCaloriesLabel(calories: 0)
        view?.setRemainingCaloriesLabelBlack()
    }
    
    func didUpdateInputField(user: User, breakfast: Int, lunch: Int, dinner: Int, snack: Int) {
        guard let dailyConsumtion = user.calorieDistribution.dailyCalorieConsumption else {
            return
        }

        HuelUserManager.shared.distributeCalories(user: user, breakfast: breakfast, lunch: lunch, dinner: dinner, snack: snack)
        
        let usedCalories = breakfast + lunch + dinner + snack
        if dailyConsumtion < usedCalories {
            view?.setRemainingCaloriesLabelRed()
        } else {
            view?.setRemainingCaloriesLabelBlack()
        }
        view?.setRemainingCaloriesLabel(calories: dailyConsumtion - usedCalories)
    }
}
