//
//  User.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import Foundation

struct User {
    enum Gender {
        case male
        case female
        case other
    }
    
    enum Goal {
        case maintain
        case lose
        case gain
    }
    
    enum ActivityLevel {
        case sedentary
        case lightly
        case moderately
        case very
        case extra
    }
    
    enum UnitOfMeasurement {
        case metric
        case imperial
    }
    
    struct CalorieDistribution {
        var breakfast = 0
        var lunch = 0
        var dinner = 0
        var snacks = 0
        lazy var total: Int = self.breakfast + self.lunch + self.dinner + self.snacks
    }
    
    var preferredUnitOfMeasurement: UnitOfMeasurement
    var age: Int
    var gender: Gender
    var height: Double
    var weight: Double
    var goal: Goal
    var activityLevel: ActivityLevel
    var calorieDistribution = CalorieDistribution()
    
    init(preferredUnitOfMeasurement: UnitOfMeasurement, age: Int, gender: Gender, height: Double, weight: Double, goal: Goal, activityLevel: ActivityLevel) {
        self.preferredUnitOfMeasurement = preferredUnitOfMeasurement
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
        self.goal = goal
        self.activityLevel = activityLevel
    }
}



