//
//  MealPlanViewController.swift
//  HuelCalculator
//
//  Created by Linda on 09/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

protocol MealPlanUI: class {
    func setBreakfastAmount(amountLabel: String?)
    func setLunchAmount(amountLabel: String?)
    func setDinnerAmount(amountLabel: String?)
    func setSnackAmount(amountLabel: String?)
}

class MealPlanViewController: UIViewController, MealPlanUI {

    @IBOutlet private var breakfastAmountLabel: UILabel!
    @IBOutlet private var lunchAmountLabel: UILabel!
    @IBOutlet private var dinnerAmountLabel: UILabel!
    @IBOutlet private var snackAmountLabel: UILabel!

    private var presenter: MealPlanPresenter?
    var product: MealReplacementProduct?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MealPlanPresenter(view: self)
        presenter?.didLoadView(with: product)
        Analytics.log(withName: "MealPlan", contentType: "Page", contentId: nil, customAttributes: nil)
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
