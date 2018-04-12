//
//  User.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import Foundation

class User {
    enum Gender: Int {
        case male
        case female
    }
    
    enum Goal: Int {
        case lose
        case maintain
        case gain
    }
    
    enum ActivityLevel: Int {
        case sedentary
        case lightly
        case moderately
        case very
        case extra
        case count
        
        static func getActivityString(activity: User.ActivityLevel) -> String {
            switch activity {
            case .sedentary:
                return "Sedentary - little or no exercise"
            case .lightly:
                return "Lightly Active - exercise 1-3 times/week"
            case .moderately:
                return "Moderately Active - exercise 3-5 times/week"
            case .very:
                return "Very Active - hard exercise 7-6 times/week"
            case .extra:
                return "Extra Active - very hard exercise or physical job"
            default:
                return "Select activity"
            }
        }
    }
    
    enum UnitOfMeasurement: Int {
        case metric
        case imperial
    }
    
    var preferredUnitOfMeasurement: UnitOfMeasurement?
    var age: Int?
    var gender: Gender?
    var height: Float?
    var weight: Float?
    var goal: Goal?
    var activityLevel: ActivityLevel?
    var calorieDistribution = CalorieDistribution()
    
    init(preferredUnitOfMeasurement: UnitOfMeasurement?, age: Int?, gender: Gender?, height: Float?, weight: Float?, goal: Goal?, activityLevel: ActivityLevel?) {
        self.preferredUnitOfMeasurement = preferredUnitOfMeasurement
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
        self.goal = goal
        self.activityLevel = activityLevel
    }
}



