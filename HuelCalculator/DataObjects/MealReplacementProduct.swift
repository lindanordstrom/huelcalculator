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

struct HuelBar: MealReplacementProduct {
    var kcalPer100gram = 406
}
