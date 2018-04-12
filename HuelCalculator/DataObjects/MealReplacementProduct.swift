//
//  MealReplacementProduct.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-09.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import Foundation

protocol Shake {
    var gramPerScoop: Int { get }
    var kcalPerScoop: Int { get }
}

protocol Bar {
    var gramPerBar: Int { get }
    var kcalPerBar: Int { get }
}

struct HuelMealReplacementProduct {
    struct HuelShake {
        struct Vanilla: Shake {
            var gramPerScoop = 38
            var kcalPerScoop = 152
        }

        struct Unflavoured {
            var gramPerScoop = 38
            var kcalPerScoop = 157
        }
    }

    struct HuelBar: Bar {
        // TODO: fix with correct data
        var gramPerBar = 0
        var kcalPerBar = 0
    }
}
