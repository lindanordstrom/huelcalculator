//
//  PersonalDetailsPresenter.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import Foundation

protocol PersonalDetailsPresentable: class {
    
}

class PersonalDetailsPresenter {
    
    private weak var view: PersonalDetailsPresentable?
    
    func set(view: PersonalDetailsPresentable) {
        self.view = view
    }
}
