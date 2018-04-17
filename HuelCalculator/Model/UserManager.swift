//
//  UserManager.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-09.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import Foundation

protocol UserManager {
    func signedInUserExists() -> Bool
    func getSignedInUser() -> User?
    func saveUserToDataStore(user: User?)
    func saveOldCalorieDistributionsIfNeeded(user: inout User?)
    func distributeCalories(breakfast: Int, lunch: Int, dinner: Int, snack: Int)
    func setUsersDailyCalorieConsumption()
}

class HuelUserManager: UserManager {
    static let shared = HuelUserManager()

    private var dataStore: DataStore

    init(dataStore: DataStore = UserDefaults.standard) {
        self.dataStore = dataStore
    }

    func signedInUserExists() -> Bool {
        return getSignedInUser() != nil
    }

    func getSignedInUser() -> User? {
        guard let userData = dataStore.object(forKey: Constants.Keys.user) as? Data else { return nil }
        return try? JSONDecoder().decode(User.self, from: userData)
    }

    func saveUserToDataStore(user: User?) {
        guard let user = user,
            let encodedUser = try? JSONEncoder().encode(user) else { return }
        dataStore.set(encodedUser, forKey: Constants.Keys.user)
    }

    func saveOldCalorieDistributionsIfNeeded(user: inout User?) {
        guard let oldUser = getSignedInUser() else {
            return
        }
        user?.calorieDistribution.breakfast = oldUser.calorieDistribution.breakfast
        user?.calorieDistribution.lunch = oldUser.calorieDistribution.lunch
        user?.calorieDistribution.dinner = oldUser.calorieDistribution.dinner
        user?.calorieDistribution.snack = oldUser.calorieDistribution.snack
    }


    func distributeCalories(breakfast: Int, lunch: Int, dinner: Int, snack: Int) {
        let user = getSignedInUser()
        user?.calorieDistribution.breakfast = breakfast
        user?.calorieDistribution.lunch = lunch
        user?.calorieDistribution.dinner = dinner
        user?.calorieDistribution.snack = snack
        saveUserToDataStore(user: user)
    }

    func setUsersDailyCalorieConsumption() {
        let user = getSignedInUser()

        guard let measurementUnit = user?.preferredUnitOfMeasurement,
            let gender = user?.gender,
            let age = user?.age,
            let weight = user?.weight,
            let height = user?.height,
            let activity = user?.activityLevel,
            let goal = user?.goal else {
                return
        }
        let genderMultiplier = getGenderMultiplier(gender: gender)
        let activityMultiplier = getActivityMultiplier(activity: activity)
        let goalConstant = getGoalConstant(goal: goal)
        let weightMultiplier = getWeightMultiplier(unit: measurementUnit)
        let heightMultiplier = getHeightMultiplier(unit: measurementUnit)

        let bmr = 10 * (weight * weightMultiplier) + 6.25 * (height * heightMultiplier) - 5 * Float(age) + genderMultiplier

        let dailyCalorieConsumtion = Int(bmr * activityMultiplier + goalConstant)

        user?.calorieDistribution.dailyCalorieConsumption = dailyCalorieConsumtion

        saveUserToDataStore(user: user)
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
