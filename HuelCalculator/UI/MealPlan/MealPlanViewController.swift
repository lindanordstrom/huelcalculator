//
//  MealPlanViewController.swift
//  HuelCalculator
//
//  Created by Linda on 09/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class MealPlanViewController: UIViewController {

    private let presenter = MealPlanPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getHuelPressed() {
        presenter.didPressGetHuel()
    }
}
