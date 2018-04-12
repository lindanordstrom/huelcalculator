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
    func removeUser()
    func getSignedInUser() -> User?
    func saveUserToDataStore(user: User)
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

    func removeUser() {
        dataStore.removeObject(forKey: "user")
    }

    func getSignedInUser() -> User? {
        guard let userAsData = dataStore.object(forKey: "user") as? Data else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: userAsData) as? User
    }

    func saveUserToDataStore(user: User) {
        let userAsData = NSKeyedArchiver.archivedData(withRootObject: user)
        self.dataStore.set(userAsData, forKey: "user")
    }

    func setUsersDailyCalorieConsumption(user: User) {
        guard let measurementUnit = user.preferredUnitOfMeasurement,
            let gender = user.gender,
            let age = user.age,
            let weight = user.weight,
            let height = user.height,
            let activity = user.activityLevel,
            let goal = user.goal else {
                return
        }
        let genderMultiplier = getGenderMultiplier(gender: gender)
        let activityMultiplier = getActivityMultiplier(activity: activity)
        let goalConstant = getGoalConstant(goal: goal)
        let weightMultiplier = getWeightMultiplier(unit: measurementUnit)
        let heightMultiplier = getHeightMultiplier(unit: measurementUnit)

        let bmr = 10 * (weight * weightMultiplier) + 6.25 * (height * heightMultiplier) - 5 * Float(age) + genderMultiplier

        let dailyCalorieConsumtion = Int(bmr * activityMultiplier + goalConstant)

        user.calorieDistribution.dailyCalorieConsumption = dailyCalorieConsumtion
    }


    func distributeCalories(user: User, breakfast: Int, lunch: Int, dinner: Int, snack: Int) {
        user.calorieDistribution.breakfast = breakfast
        user.calorieDistribution.lunch = lunch
        user.calorieDistribution.dinner = dinner
        user.calorieDistribution.snack = snack
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
