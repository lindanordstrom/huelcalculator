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

struct HuelVanillaShake: MealReplacementProduct {
    var kcalPer100gram = 400
}

struct HuelUnflavouredShake: MealReplacementProduct {
    var kcalPer100gram = 407
}

struct HuelBar: MealReplacementProduct {
    var kcalPer100gram = 382
}
