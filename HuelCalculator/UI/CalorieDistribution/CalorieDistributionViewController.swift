//
//  CalorieDistributionViewController.swift
//  HuelCalculator
//
//  Created by Linda on 09/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class CalorieDistributionViewController: UIViewController {
    
    private let presenter = CalorieDistributionPresenter()
    @IBOutlet var remainingCaloriesLabel: UILabel!
    @IBOutlet var breakfastCaloriesInputField: UITextField!
    @IBOutlet var lunchCaloriesInputField: UITextField!
    @IBOutlet var dinnerCaloriesInputField: UITextField!
    @IBOutlet var snackCaloriesInputField: UITextField!
    @IBOutlet var nextPageButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
