//
//  MealPlanPresenter.swift
//  HuelCalculator
//
//  Created by Linda on 10/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import Foundation

class MealPlanPresenter {
    private weak var view: MealPlanUI?
    private var userManager: UserManager
    
    init(view: MealPlanUI, userManager: UserManager = HuelUserManager.shared) {
        self.view = view
        self.userManager = userManager
    }
    
    func didLoadView(with product: MealReplacementProduct?) {
        guard let user = userManager.getSignedInUser(),
         let product = product else { return }

        view?.setBreakfastAmount(amountLabel: amountString(calories: user.calorieDistribution.breakfast, product: product))
        view?.setLunchAmount(amountLabel: amountString(calories: user.calorieDistribution.lunch, product: product))
        view?.setDinnerAmount(amountLabel: amountString(calories: user.calorieDistribution.dinner, product: product))
        view?.setSnackAmount(amountLabel: amountString(calories: user.calorieDistribution.snack, product: product))
    }
    
    private func amountString(calories: Int?, product: MealReplacementProduct) -> String? {
        guard let calories = calories else { return nil }
        let gram = HuelMealCalculator.gramsToReach(calories: calories, product: product)

        if product is HuelBar {
            let bars = HuelMealCalculator.numberOfBars(calories: calories, product: product)
            return String(format: Constants.MealPlanPage.numberOfBarsAndGrams, bars, gram)
        } else {
            let scoops = HuelMealCalculator.numberOfScoops(calories: calories, product: product)
            return String(format: Constants.MealPlanPage.numberOfGramsAndScoops, gram, scoops)
        }
    }
}
