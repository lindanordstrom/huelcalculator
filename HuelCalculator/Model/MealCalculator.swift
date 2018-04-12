//
//  MealCalculator.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-09.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import Foundation

class MealCalculator {
    static func numberOfScoops(calories: Int, shake: Shake) -> Float {
        return Float(calories) / Float(shake.kcalPerScoop)
    }

    static func numberOfBars(calories: Int, bar: Bar) -> Float {
        return 0
        // TODO
    }

    static func gramsOfPowder(calories: Int, shake: Shake) -> Float {
        return numberOfScoops(calories: calories, shake: shake) * 38
    }

    static func gramsOfBar(calories: Int, shake: Bar) -> Float {
        return 0
        // TODO
    }
}
