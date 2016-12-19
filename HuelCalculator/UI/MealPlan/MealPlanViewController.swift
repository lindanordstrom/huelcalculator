//
//  MealPlanViewController.swift
//  HuelCalculator
//
//  Created by Linda on 09/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class MealPlanViewController: UIViewController, MealPlanPresentable {

    @IBOutlet var breakfastAmountLabel: UILabel!
    @IBOutlet var lunchAmountLabel: UILabel!
    @IBOutlet var dinnerAmountLabel: UILabel!
    @IBOutlet var snackAmountLabel: UILabel!
    
    private let presenter = MealPlanPresenter()
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.set(view: self)
        presenter.didLoadView(user: user)
    }
    
    @IBAction func getHuelPressed() {
        presenter.didPressGetHuel()
    }
    
    func setBreakfastAmount(amountLabel: String?) {
        breakfastAmountLabel.text = amountLabel
    }
    func setLunchAmount(amountLabel: String?) {
        lunchAmountLabel.text = amountLabel
    }
    func setDinnerAmount(amountLabel: String?) {
        dinnerAmountLabel.text = amountLabel
    }
    func setSnackAmount(amountLabel: String?) {
        snackAmountLabel.text = amountLabel
    }
}
