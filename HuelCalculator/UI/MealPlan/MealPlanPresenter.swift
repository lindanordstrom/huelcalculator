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


protocol MealPlanPresentable: class {
    func setBreakfastAmount(amountLabel: String?)
    func setLunchAmount(amountLabel: String?)
    func setDinnerAmount(amountLabel: String?)
    func setSnackAmount(amountLabel: String?)
}

class MealPlanPresenter {
 
    private let urlHandler: UrlHandler
    private let huelUrl = "https://huel.com/products/huel"
    private weak var view: MealPlanPresentable?
    
    init(urlHandler: UrlHandler = UIApplication.shared) {
        self.urlHandler = urlHandler
    }
    
    func set(view: MealPlanPresentable) {
        self.view = view
    }
    
    func didPressGetHuel() {
        guard let url = URL(string: huelUrl) else {
            return
        }
        _ = urlHandler.openURL(url)
    }
    
    func didLoadView(user: User?) {
        guard let user = user else { return }
        view?.setBreakfastAmount(amountLabel: scoopsAndGramsString(calories: user.calorieDistribution.breakfast, flavour: user.flavour))
        view?.setLunchAmount(amountLabel: scoopsAndGramsString(calories: user.calorieDistribution.lunch, flavour: user.flavour))
        view?.setDinnerAmount(amountLabel: scoopsAndGramsString(calories: user.calorieDistribution.dinner, flavour: user.flavour))
        view?.setSnackAmount(amountLabel: scoopsAndGramsString(calories: user.calorieDistribution.snacks, flavour: user.flavour))
    }
    
    private func caloriesToScoops(calories: Int, flavour: User.Flavour) -> Float {
        var kcalPerScoop: Int
        switch flavour {
        case .vanilla:
            kcalPerScoop = 152
        case .unflavoured:
            kcalPerScoop = 157
        }
        
        return Float(calories) / Float(kcalPerScoop)
    }
    
    private func scoopsToGram(scoops: Float) -> Float {
        return scoops * 38
    }
    
    private func scoopsAndGramsString(calories: Int, flavour: User.Flavour?) -> String? {
        guard let flavour = flavour else { return nil }
        let scoops = caloriesToScoops(calories: calories, flavour: flavour)
        let gram = scoopsToGram(scoops: scoops)
        return String(format: "%.0f g / %.1f scoops", gram, scoops)
    }
}
