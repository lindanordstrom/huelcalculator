//
//  MealPlanViewController.swift
//  HuelCalculator
//
//  Created by Linda on 09/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class MealPlanViewController: UIViewController, MealPlanPresentable {

    private let presenter = MealPlanPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.set(view: self)
    }
    
    @IBAction func getHuelPressed() {
        presenter.didPressGetHuel()
    }
}
