//
//  MealPlanPresenter.swift
//  HuelCalculator
//
//  Created by Linda on 10/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

protocol UrlHandler {
    func openURL(_ url: URL) -> Bool
}

extension UIApplication: UrlHandler {}

class MealPlanPresenter {
 
    private let urlHandler: UrlHandler
    private let huelUrl = "https://huel.com/products/huel"
    private weak var view: MealPlanUI?
    
    init(view: MealPlanUI, urlHandler: UrlHandler = UIApplication.shared) {
        self.view = view
        self.urlHandler = urlHandler
    }
    
    func didPressGetHuel() {
        guard let url = URL(string: huelUrl) else {
            return
        }
        _ = urlHandler.openURL(url)
    }
    
    func didLoadView() {
        guard let user = HuelUserManager.shared.getSignedInUser() else { return }
        // TODO: Break out hardcoded shake type
        view?.setBreakfastAmount(amountLabel: scoopsAndGramsString(calories: user.calorieDistribution.breakfast, shake: HuelMealReplacementProduct.HuelShake.Vanilla()))
        view?.setLunchAmount(amountLabel: scoopsAndGramsString(calories: user.calorieDistribution.lunch, shake: HuelMealReplacementProduct.HuelShake.Vanilla()))
        view?.setDinnerAmount(amountLabel: scoopsAndGramsString(calories: user.calorieDistribution.dinner, shake: HuelMealReplacementProduct.HuelShake.Vanilla()))
        view?.setSnackAmount(amountLabel: scoopsAndGramsString(calories: user.calorieDistribution.snack, shake: HuelMealReplacementProduct.HuelShake.Vanilla()))
    }
    
    private func scoopsAndGramsString(calories: Int?, shake: Shake) -> String? {
        guard let calories = calories else { return nil }
        let scoops = HuelMealCalculator.numberOfScoops(calories: calories, shake: shake)
        let gram = HuelMealCalculator.gramsOfPowder(calories: calories, shake: shake)
        return String(format: "%.0f g / %.1f scoops", gram, scoops)
    }
}
