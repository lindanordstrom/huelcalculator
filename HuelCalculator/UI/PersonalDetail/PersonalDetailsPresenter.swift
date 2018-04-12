//
//  PersonalDetailsPresenter.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import Foundation

protocol PersonalDetailsPresentable: class {
    func resetAllFields()
    func showErrorMessage()
    func navigateToCalorieDistributionViewController(user: User)
    func updateUIToImperialSystem()
    func updateUIToMetricSystem()
}

class PersonalDetailsPresenter {
    
    private weak var view: PersonalDetailsPresentable?
    
    func set(view: PersonalDetailsPresentable) {
        self.view = view
    }
    
    func didPressResetButton() {
        view?.resetAllFields()
    }
    
    func didPressDoneButton(user: User) {
        HuelUserManager.shared.setUsersDailyCalorieConsumption(user: user)
        guard user.calorieDistribution.dailyCalorieConsumption != nil else {
            view?.showErrorMessage()
            return
        }
        view?.navigateToCalorieDistributionViewController(user: user)
    }
    
    func didChangeMeasurementValue(value: User.UnitOfMeasurement?) {
        guard let value = value else { return }
        switch value {
        case .imperial:
            view?.updateUIToImperialSystem()
        case .metric:
            view?.updateUIToMetricSystem()
        }
    }
}
