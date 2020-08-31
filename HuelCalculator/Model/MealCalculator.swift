//
//  MealCalculator.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-09.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

protocol MealCalculator {
    static func numberOfScoops(calories: Int, product: MealReplacementProduct) -> Float
    static func numberOfBars(calories: Int, product: MealReplacementProduct) -> Float
    static func numberOfReadyToDrinkBottles(calories: Int, product: MealReplacementProduct) -> Float
    static func gramsToReach(calories: Int, product: MealReplacementProduct) -> Float
}

class HuelMealCalculator: MealCalculator {
    private static let gramsPerScoop: Float = 50
    private static let gramsPerScoopBlack: Float = 45
    private static let gramsPerBar: Float = 49
    private static let mlPerReadyToDrinkBottle: Float = 500

    static func numberOfScoops(calories: Int, product: MealReplacementProduct) -> Float {
        let gramsPerScoop = product is HuelBlackEditionShake ? gramsPerScoopBlack : self.gramsPerScoop
        return gramsToReach(calories: calories, product: product) / gramsPerScoop
    }

    static func numberOfBars(calories: Int, product: MealReplacementProduct) -> Float {
        return gramsToReach(calories: calories, product: product) / gramsPerBar
    }
    
    static func numberOfReadyToDrinkBottles(calories: Int, product: MealReplacementProduct) -> Float {
        // counting 100ml of ready to drink Huel as 100gr
        return gramsToReach(calories: calories, product: product) / mlPerReadyToDrinkBottle
    }

    static func gramsToReach(calories: Int, product: MealReplacementProduct) -> Float {
        return (Float(calories) / Float(product.kcalPer100gram)) * 100
    }
}
