//
//  User.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import Foundation

struct User {
    enum Gender: Int {
        case male
        case female
    }
    
    enum Goal: Int {
        case lose
        case maintain
        case gain
    }
    
    enum ActivityLevel {
        case sedentary
        case lightly
        case moderately
        case very
        case extra
    }
    
    enum UnitOfMeasurement: Int {
        case metric
        case imperial
    }
    
    enum Flavour: Int {
        case vanilla
        case unflavoured
    }
    
    struct CalorieDistribution {
        var breakfast = 0
        var lunch = 0
        var dinner = 0
        var snacks = 0
        lazy var total: Int = self.breakfast + self.lunch + self.dinner + self.snacks
    }
    
    var preferredUnitOfMeasurement: UnitOfMeasurement?
    var age: Int?
    var gender: Gender?
    var height: Float?
    var weight: Float?
    var goal: Goal?
    var activityLevel: ActivityLevel?
    var flavour: Flavour?
    var dailyCalorieConsumption: Int?
    var calorieDistribution = CalorieDistribution()
    
    init(preferredUnitOfMeasurement: UnitOfMeasurement?, age: Int?, gender: Gender?, height: Float?, weight: Float?, goal: Goal?, activityLevel: ActivityLevel?, flavour: Flavour?) {
        self.preferredUnitOfMeasurement = preferredUnitOfMeasurement
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
        self.goal = goal
        self.activityLevel = activityLevel
        self.flavour = flavour
    }
}



