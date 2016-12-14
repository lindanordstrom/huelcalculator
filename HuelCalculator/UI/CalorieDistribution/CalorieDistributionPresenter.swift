//
//  CalorieDistributionPresenter.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import Foundation

protocol CalorieDistributorPresentable: class {
    
}

class CalorieDistributionPresenter {
    
    private weak var view: CalorieDistributorPresentable?
    
    func set(view: CalorieDistributorPresentable) {
        self.view = view
    }
}
