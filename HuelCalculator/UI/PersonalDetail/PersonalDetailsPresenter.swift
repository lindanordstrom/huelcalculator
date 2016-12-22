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
    
    func didPressCalculateButton(user: User) {
        var user = user
        guard let dailyCalorieConsumtion = dailyCalorieConsumtion(user: user), user.age != nil && user.height != nil && user.weight != nil && user.activityLevel != nil else {
            view?.showErrorMessage()
            return
        }
        user.dailyCalorieConsumption = Int(dailyCalorieConsumtion)
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
    
    private func dailyCalorieConsumtion(user: User) -> Float? {
        guard let measurementUnit = user.preferredUnitOfMeasurement,
            let gender = user.gender,
            let age = user.age,
            let weight = user.weight,
            let height = user.height,
            let activity = user.activityLevel,
            let goal = user.goal else {
                return nil
        }
        let genderMultiplier = getGenderMultiplier(gender: gender)
        let activityMultiplier = getActivityMultiplier(activity: activity)
        let goalConstant = getGoalConstant(goal: goal)
        let weightMultiplier = getWeightMultiplier(unit: measurementUnit)
        let heightMultiplier = getHeightMultiplier(unit: measurementUnit)
        
        let bmr = 10 * (weight * weightMultiplier) + 6.25 * (height * heightMultiplier) - 5 * Float(age) + genderMultiplier

        return bmr * activityMultiplier + goalConstant
    }
    
    private func getGenderMultiplier(gender: User.Gender) -> Float {
        switch gender {
        case .male:
             return 5
        case .female:
            return -161
        }
    }
    
    private func getActivityMultiplier(activity: User.ActivityLevel) -> Float {
        switch activity {
        case .sedentary:
            return 1.2
        case .lightly:
            return 1.375
        case .moderately:
            return 1.55
        case .very:
            return 1.725
        case .extra:
            return 1.9
        default:
            return 0
        }
    }
    
    private func getGoalConstant(goal: User.Goal) -> Float {
        switch goal {
        case .lose:
            return -500
        case .gain:
            return 500
        case .maintain:
            return 0
        }
    }
    
    private func getWeightMultiplier(unit: User.UnitOfMeasurement) -> Float {
        switch unit {
        case .imperial:
            return 0.45359237
        case .metric:
            return 1
        }
    }
    
    private func getHeightMultiplier(unit: User.UnitOfMeasurement) -> Float {
        switch unit {
        case .imperial:
            return 30.48
        case .metric:
            return 1
        }
    }
}
