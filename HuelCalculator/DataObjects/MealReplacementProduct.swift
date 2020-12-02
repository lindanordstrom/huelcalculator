//
//  MealReplacementProduct.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-09.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

protocol MealReplacementProduct {
    var kcalPer100gram: Int { get }
}

struct HuelBlackEditionShake: MealReplacementProduct {
    var kcalPer100gram = 444
}

struct HuelShake: MealReplacementProduct {
    var kcalPer100gram = 400
}

struct HuelReadyToDrink: MealReplacementProduct {
    var kcalPer100gram = 80
}

struct HuelHotAndSavoury: MealReplacementProduct {
    var kcalPer100gram = 423
    // Mexican Chilli v1.0: 425
    // Thai Green Curry v1.0: 425
    // Tomato & Herb v1.0: 421
}

struct HuelBar: MealReplacementProduct {
    var kcalPer100gram = 406
}
