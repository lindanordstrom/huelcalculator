//
//  MealCalculator.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-09.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import Foundation

protocol MealCalculator {
    static func numberOfScoops(calories: Int, product: MealReplacementProduct) -> Float
    static func numberOfBars(calories: Int, product: MealReplacementProduct) -> Float
    static func gramsToReach(calories: Int, product: MealReplacementProduct) -> Float
}

class HuelMealCalculator: MealCalculator {
    private static let gramsPerScoop: Float = 38
    private static let gramsPerBar: Float = 65

    static func numberOfScoops(calories: Int, product: MealReplacementProduct) -> Float {
        return gramsToReach(calories: calories, product: product) / gramsPerScoop
    }

    static func numberOfBars(calories: Int, product: MealReplacementProduct) -> Float {
        return gramsToReach(calories: calories, product: product) / gramsPerBar
    }

    static func gramsToReach(calories: Int, product: MealReplacementProduct) -> Float {
        return (Float(calories) / Float(product.kcalPer100gram)) * 100
    }
}
