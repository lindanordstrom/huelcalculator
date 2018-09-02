//
//  User.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import Foundation

class User: Codable {
    enum Gender: Int, Codable {
        case male
        case female
    }
    
    enum Goal: Int, Codable {
        case lose
        case maintain
        case gain
    }
    
    enum ActivityLevel: Int, Codable {
        case sedentary
        case lightly
        case moderately
        case very
        case extra
        case count
        
        static func getActivityString(activity: User.ActivityLevel) -> String {
            switch activity {
            case .sedentary:
                return Constants.User.sedentaryActive
            case .lightly:
                return Constants.User.lightlyActive
            case .moderately:
                return Constants.User.moderatelyActive
            case .very:
                return Constants.User.veryActive
            case .extra:
                return Constants.User.extraActive
            default:
                return Constants.User.selectActivity
            }
        }
    }
    
    enum UnitOfMeasurement: Int, Codable {
        case metric
        case imperial
    }
    
    var preferredUnitOfMeasurement: UnitOfMeasurement?
    var bornYear: String?
    var gender: Gender?
    var height: Float?
    var weight: Float?
    var goal: Goal?
    var activityLevel: ActivityLevel?
    var calorieDistribution = CalorieDistribution()
    var age: Int?
    
    init(preferredUnitOfMeasurement: UnitOfMeasurement?, bornYear: String?, gender: Gender?, height: Float?, weight: Float?, goal: Goal?, activityLevel: ActivityLevel?) {
        self.preferredUnitOfMeasurement = preferredUnitOfMeasurement
        self.bornYear = bornYear
        self.gender = gender
        self.height = height
        self.weight = weight
        self.goal = goal
        self.activityLevel = activityLevel
    }
}



