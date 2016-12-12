//
//  MealPlanPresenter.swift
//  HuelCalculator
//
//  Created by Linda on 10/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

protocol UrlHandler {
    func open(_: URL, options: [String : Any], completionHandler: ((Bool) -> Void)?)
}

extension UIApplication: UrlHandler {}


protocol MealPlanPresentable: class {
    
}

class MealPlanPresenter {
 
    private weak var view: MealPlanPresentable?
    
    private let urlHandler: UrlHandler
    
    init(urlHandler: UrlHandler = UIApplication.shared) {
        self.urlHandler = urlHandler
    }
    
    func set(view: MealPlanPresentable) {
        self.view = view
    }
    
    func didPressGetHuel() {
        guard let url = URL(string: "http://www.huel.com") else {
            return
        }
        urlHandler.open(url, options: [:], completionHandler: nil)
    }
}
